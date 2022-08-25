# frozen_string_literal: true

# CartsController
class CartsController < ApplicationController
  def show
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
      @cart_items = @cart.cart_items
    end
  end

  def new; end

  def create; end
end
