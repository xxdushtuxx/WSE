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
  
    private
  
    def order_params
      params.require(:order).permit(:total_price)
    end

    def check_authentication
        unless logged_in?
          redirect_to login_path, alert: 'You must be logged in to access this page.'
        end
      end
    
    def order_details 
        #@user_details = { province_id: current_customer.province_id, firstname: current_customer.firstname,  lastname: current_customer.lastname,  email: current_customer.email, phone: current_customer.phone, address: current_customer.address, city: current_customer.city}
=begin        @order_details = {}
        session[:cart].each do |item|
          id = item[:id]
          quantity = item[:quantity]
          puts "ID: #{id}, Quantity: #{quantity}"

          @product = Product.find(id)

          #@order_details += {product_name: @product.name, @product}
        end

        @user = Customer.find(current_customer.id)
=end

    end
  end
  