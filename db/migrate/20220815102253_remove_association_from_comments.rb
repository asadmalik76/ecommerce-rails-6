class RemoveAssociationFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_reference :comments, :commentable, polymorphic: true
  end
end
