class AddAssociationInComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :product
  end
end
