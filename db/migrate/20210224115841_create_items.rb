class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :quantity
      t.integer :category
      t.string :itemType
      t.string :size

      t.timestamps
    end
  end
end
