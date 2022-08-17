class AddDiscountColumnInOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :discount, :float
  end
end
