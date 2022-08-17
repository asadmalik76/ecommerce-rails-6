class AddColoumInCouponsTable < ActiveRecord::Migration[6.1]
  def change
    add_column :coupons, :coupon, :string
  end
end
