# frozen_string_literal: true

# CRUD for brands
class BrandsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_brand, only: %i[edit update destroy]
  before_action :load_brands, only: %i[index]
  before_action :load_new_brand, only: %i[new]

  def index; end

  def new; end

  def create
    @brand = Brand.new(brand_params)
    authorize @brand
    if @brand.save
      flash[:success] = 'New Brand created'
      redirect_to brands_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @brand.update(brand_params)
      flash[:success] = 'Brand updated'
      redirect_to brands_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @brand.destroy
    flash[:success] = 'Brand Destroyed'
    redirect_to brands_path
  end

  private

  def brand_params
    params.require(:brand).permit(:name)
  end

  def load_brand
    @brand = Brand.find(params[:id])
    authorize @brand
  end

  def load_brands
    @brands = Brand.all
    authorize @brands
  end

  def load_new_brand
    @brand = Brand.new
    authorize @brand
  end
end
