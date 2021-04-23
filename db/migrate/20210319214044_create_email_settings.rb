class CreateEmailSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :email_settings do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :preference

      t.timestamps
    end
  end
end
