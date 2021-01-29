class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.integer :urgency
      t.string :full_name
      t.string :email
      t.integer :phone
      t.integer :type
      t.integer :county
      t.boolean :meet
      t.string :availability
      t.text :comments

      t.timestamps
    end
  end
end
