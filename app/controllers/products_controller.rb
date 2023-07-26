class ProductsController < ApplicationController
  before_action :initialize_cart_session
  before_action :load_cart

  def index
    @categories = Category.all
    @category_id = params[:category_id]
    @query = params[:query]

    if @query.present?
      # Base query to search for products based on the keyword
      @products = Product.where("name LIKE ? OR description LIKE ?", "%#{@query}%", "%#{@query}%")

      # Filter by category if selected
      if @category_id.present?
        @products = @products.where(category_id: @category_id)
      end

      # Paginate the search results
      @products = @products.page(params[:page]).per(10)
    else
      @products = Product.all.page(params[:page]).per(20)
    end

    if params[:sale_status] == "yes"
      @products = @products.where(sale_status: "yes")
    elsif params[:new_product] == "yes"
      @products = @products.where('created_at >= ?', 1.days.ago)
    elsif params[:recently_updated] == "yes"
      @products = @products.where('updated_at >= ?', 3.days.ago)
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: 'Product was successfully deleted.'
  end

  # Cart methods 
  def add_to_cart
    id = params[:id].to_i
    quantity = params[:quantity].to_i # Assuming quantity is passed as a parameter in the request
    session[:cart] << { id: id, quantity: quantity } unless session[:cart].any? { |item| item[:id] == id }
    redirect_to products_path
  end

  def remove_from_cart
    id = params[:id].to_i
  
    puts "Product ID to remove: #{id}"
    puts "Cart before removal: #{session[:cart].inspect}"
  
    session[:cart].delete(id)
  
    puts "Cart after removal: #{session[:cart].inspect}"
  
    redirect_to products_path
  end

  def update_quantity
    product_id = params[:id].to_i
    quantity = params[:quantity].to_i
  
    cart_item = session[:cart].find { |item| item["id"] == product_id }
  
    puts "Product ID: #{product_id}"
    puts "Cart: #{session[:cart].inspect}"
  
    if cart_item
      cart_item["quantity"] = quantity
      flash[:notice] = "Quantity updated successfully."
    else
      flash[:error] = "Product not found in the cart."
    end
  

    redirect_to cart_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :stock, :price, :category_id)
  end

  def initialize_cart_session
    session[:cart] ||= []
  end

  def load_cart
    cart_ids = session[:cart].map { |item| item["id"] }
    @cart = Product.where(id: cart_ids)
  end
  

end
