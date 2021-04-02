class AddSettledToItemChange < ActiveRecord::Migration[6.1]
  def change
    add_column :item_changes, :settled, :integer, default: 0
  end
end
