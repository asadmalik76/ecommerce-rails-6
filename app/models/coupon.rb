class Coupon < ApplicationRecord
  validates :code, presence: true
end
