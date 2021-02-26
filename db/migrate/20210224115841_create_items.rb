class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :quantity
      t.references :category, null: false, foreign_key: true
      t.string :itemType
      t.string :size

      t.timestamps
    end
  end
end
