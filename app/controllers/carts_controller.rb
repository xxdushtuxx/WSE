class CartsController < ApplicationController
    before_action :initialize_cart_session
    before_action :load_cart

    def index
        cart_ids = session[:cart].map { |item| item["id"] }
        @cart_items = Product.where(id: cart_ids)
      end

    def add_to_cart
        id = params[:id].to_i  
        session[:cart] << id unless session[:cart].include?(id)
        redirect_to products_path
    end

    def remove_cart
        id = params[:id].to_i  
        session[:cart].delete(id)
        redirect_to products_path
    end

    def update_quantity
        product_id = params[:product_id].to_i
        quantity = params[:quantity].to_i
        cart_item = session[:cart].find { |item| item["id"] == product_id }
        
        if cart_item
          cart_item["quantity"] = quantity
          flash[:notice] = "Quantity updated successfully."
        else
          flash[:error] = "Product not found in the cart."
        end
    
        redirect_to carts_path
      end
    
    private

    def initialize_cart_session
        session[:cart] ||= []
    end
    
    def load_cart
        cart_ids = session[:cart].map { |item| item["id"] }
        products = Product.where(id: cart_ids)
        @cart = products.each_with_object([]) do |product, cart_items|
          cart_item = session[:cart].find { |item| item["id"] == product.id }
          quantity = cart_item["quantity"] if cart_item
          cart_items << { product: product, quantity: quantity || 0 }
        end
      end
      
      
end
