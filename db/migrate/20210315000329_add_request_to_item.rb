class AddRequestToItem < ActiveRecord::Migration[6.1]
  def change
    add_reference :items, :request, null: true, foreign_key: true
  end
end
