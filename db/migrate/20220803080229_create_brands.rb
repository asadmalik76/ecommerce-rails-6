class CreateBrands < ActiveRecord::Migration[6.1]
  def change
    create_table :brands do |t|
      t.text :name
      t.string :slug
      t.timestamps
    end
  end
end
