class AddCartToItemChange < ActiveRecord::Migration[6.1]
  def change
    add_reference :item_changes, :item_changes, foreign_key: true
  end
end
