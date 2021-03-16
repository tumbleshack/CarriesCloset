class AddItemChangeToCategories < ActiveRecord::Migration[6.1]
  def change
    add_reference :item_changes, :category, foreign_key: true
    add_reference :item_changes, :request, foreign_key: true
    add_reference :item_changes, :donation, foreign_key: true
  end
end
