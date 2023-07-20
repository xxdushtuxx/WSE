class ProductsController < ApplicationController
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

  private

  def product_params
    params.require(:product).permit(:name, :stock, :price, :category_id)
  end
end
