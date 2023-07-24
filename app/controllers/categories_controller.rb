class CategoriesController < ApplicationController
  def index
    @categories = Category.page(params[:page]).per(10)
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(10)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path, notice: 'Category was successfully deleted.'
  end

  def products
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(10)
  
    render 'products', locals: { products: @products }
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
