class AddColumnInCouponsTable < ActiveRecord::Migration[6.1]
  def change
    rename_column :coupons, :coupon, :code
    add_column :coupons, :discount, :float
  end
end
