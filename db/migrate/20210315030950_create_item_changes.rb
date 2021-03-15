class CreateItemChanges < ActiveRecord::Migration[6.1]
  def change
    create_table :item_changes do |t|
      t.integer :quantity
      t.string :itemType
      t.string :size
      t.column :type, :integer, null: false

      t.timestamps
    end
  end
end
