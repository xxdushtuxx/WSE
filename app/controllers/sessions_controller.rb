class SessionsController < ApplicationController
    def new
    end
  
    def create
        user = Admin.find_by(username: session_params[:username])
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

    def session_params
        params.require(:session).permit(:username, :password)
    end
      
  end
  