class ItemBelongsTo < ActiveRecord::Migration[6.1]
  def change
    remove_column :requests, :items, :string, if_exists: true
  end
end
