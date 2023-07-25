class ApplicationController < ActionController::Base

    before_action :set_categories
    helper_method :current_customer, :logged_in?

    def current_customer
      @current_customer ||= Customer.find_by(id: session[:customer_id])
    end
  
    def logged_in?
      !current_customer.nil?
    end

    private

    def set_categories
      @product_categories = Category.all
    end
  end
  