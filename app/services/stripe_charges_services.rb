# frozen_string_literal: true

# stripe charges services

class StripeChargesServices
  DEFAULT_CURRENCY = 'usd'

  def initialize(params, user, order)
    @stripe_email = params[:stripeEmail]
    @stripe_token = params[:stripeToken]
    @order = order
    @user = user
  end

  def call
    create_charge(find_customer)
  end

  private

  attr_accessor :user, :stripe_email, :stripe_token, :order

  def find_customer
    if user.stripe_token
      retrieve_customer(user.stripe_token)
    else
      create_customer
    end
  end

  def retrieve_customer(stripe_token)
    Stripe::Customer.retrieve(stripe_token)
  end

  def create_customer
    customer = Stripe::Customer.create(
      email: stripe_email,
      source: stripe_token
    )
    user.update(stripe_token: customer.id)
    customer
  end

  def create_charge(customer)
    Stripe::Charge.create(
      customer: customer.id,
      amount: order_amount,
      description: customer.email,
      currency: DEFAULT_CURRENCY
    )
  end

  def order_amount
    @amount = @order.amount * 100
    @amount.to_i
    # Order.find_by(order_id: order).amount.to_i * 100
  end
end
