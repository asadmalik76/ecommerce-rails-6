class AddRefernceInOrderItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :order_items, :order
    add_reference :order_items, :product
  end
end
