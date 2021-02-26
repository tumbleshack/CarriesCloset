class CreateVersions < ActiveRecord::Migration[6.1]
  def change
    create_table :versions do |t|
      # The referenced item, which may have many (or no) versions linked to it.
      t.references :item, null: false, foreign_key: true

      # Each version of an item has a different category
      t.references :category, null: false, foreign_key: true

      # "Metadata" for the version, representing data about a specific version
      # of an item.
      t.integer :quantity, default: 0
      t.string :size

      t.timestamps
    end
  end
end
