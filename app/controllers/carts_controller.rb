class CartsController < ApplicationController
    before_action :initialize_cart_session
    before_action :load_cart

    def index
        load_cart
    end

    def add_to_cart
        id = params[:id].to_i  
        session[:cart] << id unless session[:cart].include?(id)
        redirect_to products_path
    end

    def remove_from_cart
        id = params[:id].to_i  
        session[:cart].delete(id)
        redirect_to products_path
    end

    private

    def initialize_cart_session
        session[:cart] ||= []
    end
    
    def load_cart
        @cart = Product.find(session[:cart])
    end
end
