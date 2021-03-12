class AddFieldsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :admin,     :boolean, default: false
    add_column :users, :volunteer, :boolean, default: false
    add_column :users, :donee,     :boolean, default: false
    add_column :users, :donor,     :boolean, default: false
  end
end
