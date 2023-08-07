class OrdersController < ApplicationController
    #before_action :check_authentication
    #before_action :order_details
    
    def index
      #@orders = current_customer.orders
      #@invoice = 
      @customer = current_customer
    end
  
    def show
      @order = current_customer.orders.find(params[:id])
    end
  
    def new
      @order = current_customer.orders.build
    end
  
    def create
      @order = current_customer.orders.build(order_params)
  
      if @order.save
        redirect_to @order, notice: 'Order was successfully created.'
      else
        render :new
      end
    end
  
    def proceed_to_payment
      # Create the order record
      @order = current_customer.orders.build
      @order.total_price = calculate_total_price
      @order.province = current_customer.province
      @order.tax = calculate_tax_amount
      @order.status = 'new' # Assuming the default status is 'new'
      @order.save
    
      # Create the orderItems records
      session[:cart].each do |item|
        product = Product.find(item["id"])
        quantity = item["quantity"].to_i
        order_item = @order.order_items.build(product: product, quantity: quantity, cost: product.price * quantity)
        order_item.save
      end

      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    
      # Calculate the total price in cents for Stripe
      total_price_in_cents = (@order.total_price * 100).to_i # Convert to cents and ensure it's an integer
    
      # Build the line items array for the Stripe Checkout session
      line_items = session[:cart].map do |item|
        product = Product.find(item["id"])
        {
          price_data: {
            currency: 'cad', # Replace 'usd' with your desired currency
            product_data: {
              name: product.name, # Use the product name from the database
            },
            unit_amount: (product.price * 100).to_i, # Convert product price to cents
          },
          quantity: item["quantity"].to_i,
        }
      end
    
      
      # Create a Stripe Session with the line items
      stripe_session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: line_items,
        mode: 'payment',
        success_url: order_success_url(@order), # Replace with the URL where users should be redirected after successful payment
        cancel_url: order_cancel_url(@order),   # Replace with the URL where users should be redirected if they cancel the payment
      )
    
      # Redirect the customer to the Stripe Checkout page
      redirect_to stripe_session.url, status: :see_other, allow_other_host: true

    end
    
    
    

    def order_success
      # Retrieve the order and update its status as paid or perform any other actions needed
      @order = Order.find(params[:id])
      @order.update(status: 'paid')
      session.delete(:cart)
      # redirect_to order_success_path(@order), notice: 'Payment successful! Your order is now paid.'
    end
  
    def order_cancel
      # Handle the case where the user cancels the payment or any other necessary actions
      @order = Order.find(params[:id])
      #redirect_to order_path(@order), alert: 'Payment canceled. Your order was not processed.'
    end

    private
  
    def order_params
      params.require(:order).permit(:total_price)
    end

    def check_authentication
        unless logged_in?
          redirect_to login_path, alert: 'You must be logged in to access this page.'
        end
      end
    
      def calculate_total_price
        # Calculate the total price here based on the order items and any other applicable charges.
        # You can use the same logic as you used to calculate the sub_total_price and tax in the view.
        # For simplicity, let's assume the total price is just the sub_total_price.
        sub_total_price = 0
        session[:cart].each do |item|
          product = Product.find(item["id"])
          item_price = product.price * item["quantity"].to_i
          sub_total_price += item_price
        end
        sub_total_price
      end
=begin
      def calculate_tax_amount
        # Calculate the tax amount based on the customer's province and the sub_total_price.
        # For simplicity, let's assume the tax rate is stored in the Province model and is called 'applicable'.
        tax_rate = current_customer.province.applicable
        sub_total_price = calculate_total_price
        tax_amount = sub_total_price * tax_rate
        tax_amount.round(2) # Round to two decimal places
      end
=end

    def calculate_tax_amount
      # Fetch the customer's province and corresponding tax rates (PST, GST, HST)
      province = current_customer.province
      pst_rate = province.pst
      gst_rate = province.gst
      hst_rate = province.hst

      # Calculate the sub_total_price (replace this line with your own calculation method)
      sub_total_price = calculate_total_price

      # Calculate the tax amounts for each tax rate
      pst_amount = sub_total_price * pst_rate
      gst_amount = sub_total_price * gst_rate
      hst_amount = sub_total_price * hst_rate

      # Round each tax amount to two decimal places
      pst_amount = pst_amount.round(2)
      gst_amount = gst_amount.round(2)
      hst_amount = hst_amount.round(2)

      tax_amount = pst_amount + gst_amount + hst_amount
      tax_amount.round(2)
    end


  end
  