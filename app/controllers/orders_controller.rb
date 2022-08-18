# frozen_string_literal: true

# OrdersController
class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_cart, only: %i[create]

  def index
    @orders = current_user.orders.all
    render 'orders/myorders'
  end

  def show
    @order = Order.find_by(order_id: params[:id])
    session[:order_id] = @order.order_id
  end

  def create
    @order = Order.new
    @order.user_id = current_user.id
    @order.save
    @total_amount = 0
    @cart.cart_items.each do |item|
      @order_items = OrderItem.new
      @order_items.assign_attributes({ order_id: @order.id, product_id: item.product_id,
                                       quantity: item.quantity, status: :draft })
      @total_amount = item.product.price * item.quantity + @total_amount
      @order_items.save
    end
    @order.amount = @total_amount
    @order.status = 'draft'
    @order.save
    redirect_to order_path(@order.order_id)
  end

  def myorders
    @orders = current_user.orders.all
    render 'orders/myorders'
  end

  def apply_coupon
    @coupon = Coupon.find_by!(code: coupon_params[:code])
    @order = Order.find_by(order_id: coupon_params[:order_id])
    @discount = @order.amount * @coupon.discount
    @order.amount = @order.amount - @discount
    @order.discount = @discount
    @order.save
    render 'orders/show'
  end

  def order_products
    @products = current_user.products
    @order_items = OrderItem.where(product_id: @products.ids)
  end

  def order_product_status
    @order_item = OrderItem.find(params[:item_id])
    @order_item.status = params[:status]
    @order_item.save
    session['flash'] = 'Order Product Update successfully'
    redirect_to order_products_path
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    flash[:success] = 'Order Destroyed'
    redirect_to myorders_path
  end

  private

  def load_cart
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else
      redirect_to root_path
    end
  end

  def set_order; end

  def load_order
    if session[:order_id]
      @order = Order.find_by(order_id: session[:order_id])
    else
      redirect_to root_path
    end
  end

  def coupon_params
    params.permit(:code, :order_id)
  end
end
