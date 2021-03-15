class ItemBelongsTo < ActiveRecord::Migration[6.1]
  def change
    remove_column :requests, :items, :string, if_exists: true
    remove_column :items, :request, if_exists: true
    add_column :items, :in_inventory, :boolean, null: false, default: false
    add_column :items, :in_request, :boolean, null: false, default: false
    add_column :items, :in_donation, :boolean, null: false, default: false
  end
end
