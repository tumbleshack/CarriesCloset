class AddStatusToRequest < ActiveRecord::Migration[6.1]
  def change
    add_column :requests, :status, :integer, default: 0
  end
end
