# frozen_string_literal: true

class CommentsController < ApplicationController
  def index
    @product = Product.find(params[:id])
    @comments = @product.comments
  end

  def new; end

  def edit
    @comment = Comment.find(params[:id])
    authorize @comment
    @product = @comment.product
    respond_to do |format|
      format.html { redirect_to @product }
      format.js do
        render template: 'comments/edit.js.erb',
               layout: false
      end
    end
  end

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.new(comment_params)
    @comment.user = current_user
    authorize @comment
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @product }
        format.js do
          render template: 'comments/create.js.erb',
                 layout: false
        end
      end
    else
      flash[:alert] = 'Comment failed to save...'
      redirect_to root_path
    end
  end

  def update
    @comment = Comment.find(params[:id])
    authorize @comment
    if @comment.update(comment_params)
      respond_to do |format|
        format.html { redirect_to @comment.product }
        format.js do
          render template: 'comments/update.js.erb',
                 layout: false
        end
      end
    else
      flash[:alert] = 'Comment failed to update...'
      redirect_to root_path
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @product = @comment.product
    if @comment.delete
      respond_to do |format|
        format.html { redirect_to @product }
        format.js do
          render template: 'comments/destroy.js.erb',
                 layout: false
        end
      end
    else
      flash[:alert] = 'Comment failed to delete...'
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:id, :content, :product_id)
  end
end
