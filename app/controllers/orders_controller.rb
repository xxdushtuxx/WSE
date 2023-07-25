class OrdersController < ApplicationController
    before_action :authenticate_customer!
    
    def index
      @orders = current_customer.orders
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
  end
  