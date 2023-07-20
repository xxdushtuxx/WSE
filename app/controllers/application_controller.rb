class ApplicationController < ActionController::Base
    before_action :set_categories
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
    

    private
  
    def set_categories
      @categories = Category.all
    end
  end
  