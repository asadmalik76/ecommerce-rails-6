# frozen_string_literal:

# cart items controller

class CartItemsController < ApplicationController
  before_action :load_cart, only: %i[create]
  before_action :load_item, only: %i[create]
  before_action :load_cart_item, only: %i[increament decreament remove_item]
  def index; end

  def new; end

  # TODO: Improve this method
  def create
    if @cart.cart_items.find_by(product_id: @item.id)
      @cart_item = @cart.cart_items.find_by(product_id: @item.id)
      @cart_item.quantity += 1
      @cart_item.save
      render plain: 'success'
    else
      @cart_item = CartItem.new(
        cart_id: @cart.id, product_id: @item.id, quantity: 1
      )
      authorize @cart_item
      if @cart_item.save
        render plain: 'success'
      else
        render plain: 'failed'
      end
    end
  end

  def increament
    @cart_item.quantity += 1
    @cart_item.save
  end

  def decreament
    @cart_item.quantity -= 1
    @cart_item.save
  end

  def remove_item
    if @cart_item.destroy
      render plain: 'Deleted', status: 200
    else
      render plain: 'Failed', status: 404
    end
  end

  private

  # TODO: Improve this
  def load_cart
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    elsif user_signed_in?
      @cart = Cart.create(user_id: current_user.id)
      session[:cart_id] = @cart.id
    elsif @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end

  def cart_item_params
    params.require(:cart_item).permit(:id)
  end

  def load_item
    @item = Product.find(params[:id])
  end

  def load_cart_item
    @cart_item = CartItem.find(params[:id])
  end
end
