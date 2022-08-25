# frozen_string_literal: true

# Products CRUD
class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :load_product, only: %i[edit update destroy]
  before_action :load_seller_products, only: %i[index]

  def index; end

  def new
    @product = Product.new
  end

  def show
    @product = Product.find_by(slug: params[:id])
    @comments = @product.comments
    @comment = @product.comments.build
    render 'index/product'
  end

  def create
    @product = current_user.products.new(product_params)
    if @product.save
      flash[:success] = 'New Product created'
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      flash[:success] = 'Product updated'
      redirect_to products_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = 'Product Destroyed'
    else
      flash[:error] = 'Could not delete product'
    end
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity, :status, :category_id, :brand_id,
                                    :main_image, images: [])
  end

  def load_product
    @product = Product.find(params[:id])
    authorize @product
  end

  def load_seller_products
    @products = current_user.products.all
    authorize @products
  end
end
