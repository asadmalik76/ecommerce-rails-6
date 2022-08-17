class AddDefaultValueInOrderStatus < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :status, :integer, default: 'Draft'
  end
end
