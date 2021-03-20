class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.integer :urgency
      t.string :full_name
      t.string :email
      t.string :phone
      t.integer :relationship
      t.integer :county
      t.integer :meet
      t.string :address
      t.string :availability
      t.string :items
      t.text :comments

      t.timestamps
    end
  end
end
