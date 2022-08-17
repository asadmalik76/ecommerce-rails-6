class AddOrderIdFieldInOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :order_id, :string
  end
end
