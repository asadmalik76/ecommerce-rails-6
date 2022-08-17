class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :sku
      t.string :name
      t.text :description
      t.float :price
      t.integer :status
      t.integer :quantity
      t.string :slug
      t.timestamps
    end
  end
end
