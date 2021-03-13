class RequestHasItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :items, :request, index: true, foreign_key: true
  end
end
