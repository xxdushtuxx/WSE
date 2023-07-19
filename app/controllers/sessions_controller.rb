class SessionsController < ApplicationController
    def new
    end
  
    def create
      user = Admin.find_by(username: params[:session][:username])
      if user && user.authenticate(params[:session][:password])
        session[:admin_id] = user.id
        redirect_to admin_dashboard_index_path, notice: 'Logged in successfully!'
      else
        flash.now[:alert] = 'Invalid username or password'
        render 'new'
      end
    end
  
    def destroy
      session[:admin_id] = nil
      redirect_to login_path, notice: 'Logged out successfully!'
    end
  end
  