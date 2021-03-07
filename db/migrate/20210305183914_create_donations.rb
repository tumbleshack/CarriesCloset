class CreateDonations < ActiveRecord::Migration[6.1]
  def change
    create_table :donations do |t|
      t.string :full_name
      t.string :email
      t.string :phone
      t.integer :county
      t.boolean :meet
      t.string :address
      t.string :availability
      t.string :items
      t.text :comments

      t.timestamps
    end
  end
end
