class AddStatusFieldInOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :status, :int
  end
end
