# frozen_string_literal: true

# Stripe Controller

class ChargesController < ApplicationController
  rescue_from Stripe::CardError, with: :catch_exception
  before_action :authenticate_user!
  def new; end

  def create
    @order = Order.find_by(order_id: session[:order_id])
    @charge = StripeChargesServices.new(charges_params, current_user, @order).call
    if @charge.paid || @charge.status == 'succeeded'
      @order = Order.find_by(order_id: session[:order_id])
      @order.status = 'processing'
      @order.save
      session[:cart_id] = nil
      render 'orders/success'
    else
      redirect_to orders_path
    end
  end

  private

  def charges_params
    params.permit(:stripeEmail, :stripeToken)
  end

  def catch_exception(exception)
    flash[:error] = exception.message
  end
end
