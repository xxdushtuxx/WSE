class ApplicationController < ActionController::Base

    before_action :set_categories
    helper_method :current_customer, :logged_in?
=begin
    helper_method :current_admin, :logged_in?
  
    def current_admin
      @current_admin ||= Admin.find_by(id: session[:admin_id])
    end
  
    def logged_in?
      !!current_admin
    end
  
    def require_admin
      redirect_to login_path, alert: 'You must be logged in as an admin to access this page' unless logged_in?
    end
    
=end
    private

    def set_categories
      @product_categories = Category.all
    end

    

  def current_customer
    @current_customer ||= Customer.find_by(id: session[:customer_id])
  end

  def logged_in?
    !current_customer.nil?
  end

  end
  