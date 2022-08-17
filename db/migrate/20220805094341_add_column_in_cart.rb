class AddColumnInCart < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :session_id, :integer
    add_reference :carts, :user
  end
end
