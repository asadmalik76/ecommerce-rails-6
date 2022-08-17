class AddReferenceInComments < ActiveRecord::Migration[6.1]
  def change
    def change
      add_reference :comments, :product
    end
  end
end
