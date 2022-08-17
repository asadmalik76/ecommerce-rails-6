class RolifyCreateSellers < ActiveRecord::Migration[6.1]
  def change
    create_table(:sellers) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:users_sellers, :id => false) do |t|
      t.references :user
      t.references :seller
    end

    add_index(:sellers, [ :name, :resource_type, :resource_id ])
    add_index(:users_sellers, [ :user_id, :seller_id ])
  end
end
