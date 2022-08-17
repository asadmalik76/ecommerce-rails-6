class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.integer :status
      t.timestamps
    end
  end
end
