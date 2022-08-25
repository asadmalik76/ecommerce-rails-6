# frozen_string_literal: true

# Website Pages
class IndexController < ApplicationController
  before_action :load_categories, only: %i[index all_products brand_products category_products search_products]
  before_action :load_brands, only: %i[index all_products brand_products category_products search_products]
  before_action :load_products, only: %i[index all_products brand_products category_products]

  def index; end

  def unauthorized
    render 'errors/unauthorized'
  end

  def notfound
    render 'errors/notfound'
  end

  def all_products; end

  def brand_products
    @brand = Brand.find_by(slug: params[:slug])
    @products = @brand.products
    render 'index/all_products'
  end

  def category_products
    @category = Category.find_by(slug: params[:slug])
    @products = @category.products
    render 'index/all_products'
  end

  def search_products
    @products = Product.where('name LIKE ?', "%#{params[:query]}%")
    render 'index/all_products'
  end

  private

  def load_categories
    @categories = Category.all
  end

  def load_brands
    @brands = Brand.all
  end

  def load_products
    @products = Product.all
  end
end
