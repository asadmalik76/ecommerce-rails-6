class OrderItem < ApplicationRecord
  enum status: %i[draft pending processing delivered]
  belongs_to :order
  belongs_to :product
end
