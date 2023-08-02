class OrdersController < ApplicationController
    before_action :check_authentication
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
  
      # Redirect the customer to the payment page with the order ID
      redirect_to payment_path(@order.id)
    end

    def payment
      @order = Order.find(params[:id])
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
    
      def calculate_tax_amount
        # Calculate the tax amount based on the customer's province and the sub_total_price.
        # For simplicity, let's assume the tax rate is stored in the Province model and is called 'applicable'.
        tax_rate = current_customer.province.applicable
        sub_total_price = calculate_total_price
        tax_amount = sub_total_price * tax_rate
        tax_amount.round(2) # Round to two decimal places
      end
  end
  