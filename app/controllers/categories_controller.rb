# frozen_string_literal: true

# CRUD for Category
class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_category, only: %i[edit update destroy]
  before_action :load_categories, only: %i[index]
  before_action :load_new_category, only: %i[new]

  def index; end

  def new; end

  def create
    @category = Category.new(category_params)
    authorize @category
    if @category.save
      flash[:success] = 'New category created'
      redirect_to categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:success] = 'Category updated'
      redirect_to categories_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    flash[:success] = 'Category Destroyed'
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def load_category
    @category = Category.find(params[:id])
    authorize @category
  end

  def load_categories
    @categories = Category.all
    authorize @categories
  end

  def load_new_category
    @category = Category.new
    authorize @category
  end
end
