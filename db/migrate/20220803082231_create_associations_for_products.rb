class CreateAssociationsForProducts < ActiveRecord::Migration[6.1]
  def change
    add_reference :products, :category
    add_reference :products, :brand
    add_reference :products, :user
  end
end
