class AddFieldsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :admin,     :bool, default: false
    add_column :users, :volunteer, :bool, default: false
    add_column :users, :donee,     :bool, default: false
    add_column :users, :donor,     :bool, default: false
  end
end
