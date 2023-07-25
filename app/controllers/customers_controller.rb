class CustomersController < ApplicationController
    def new
      @customer = Customer.new
    end
  
    def create
      @customer = Customer.new(customer_params)
  
      if @customer.save
        # Handle successful signup
        redirect_to root_path, notice: 'Signup successful!'
      else
        # Handle signup errors
        render :new
      end
    end
  
    def login_form
      # Display the login form
      @customer = Customer.new
    end
  
    def login
      @customer = Customer.find_by(email: params[:email])
  
      if @customer && @customer.authenticate(params[:password])
        # Successful login
        session[:customer_id] = @customer.id
        redirect_to root_path, notice: 'Login successful!'
      else
        # Failed login
        flash.now[:alert] = 'Invalid email or password'
        render :login_form
      end
    end

    def logout
        session[:customer_id] = nil
        redirect_to root_path, notice: 'Logged out successfully!'
    end
  
    private
  
    def customer_params
        params.require(:customer).permit(:first_name, :last_name, :email, :phone, :address, :city, :postal_code, :province_id, :password)
      end
  end
  