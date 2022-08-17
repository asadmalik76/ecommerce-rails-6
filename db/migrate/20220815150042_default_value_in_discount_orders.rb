class DefaultValueInDiscountOrders < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :discount, :float, default: 0.0
  end
end
