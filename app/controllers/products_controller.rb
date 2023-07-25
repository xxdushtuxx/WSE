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

  def add_to_cart
    id = params[:id].to_i  
    session[:cart] << id unless session[:cart].include?(id)
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :stock, :price, :category_id)
  end

  def initialize_cart_session
    session[:cart] ||= []
  end

  def load_cart
    @cart = Product.find(session[:cart])
  end

end
