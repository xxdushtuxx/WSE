class CustomersController < ApplicationController
    def new
      @customer = Customer.new
    end

    def show
      @customer = current_customer
      @orders = @customer.orders.includes(:order_items)

    end
  
    def create
      puts "In here"
      @customer = Customer.new(customer_all_params)
  
    if @customer.save
        # Handle successful signup
        flash[:notice] = 'Signup successful!'
        redirect_to root_path
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
        session.delete(:cart)
        session[:customer_id] = @customer.id
        session[:welcome_message_displayed] = true
        redirect_to root_path#, notice: 'Login successful!'
      else
        # Failed login
        #flash.now[:alert] = 'Invalid email or password'
        flash[:notice] = 'Invalid email or password'
        render :login_form
      end
    end

    def logout
        session[:customer_id] = nil
        session.delete(:cart)
        flash[:notice] = 'Logged out successfully!'
        redirect_to root_path#, notice: 'Logged out successfully!'
    end

    def update_address
      @customer = current_customer
      puts "Current customer ID: #{current_customer&.id}"
      puts "Customer params: #{customer_params}"
      
      if @customer.update(customer_params)
        redirect_to invoice_path(@customer.id), notice: 'Address updated successfully.'
      else
        render :edit
      end
    end
    
  
    private
  
    def customer_params
      params.require(:customer).permit(:address, :city, :postal_code, :province_id)
    end
    def customer_all_params
      params.require(:customer).permit(:first_name, :last_name, :email, :phone, :address, :city, :postal_code, :province_id, :password)
    end
  end
  