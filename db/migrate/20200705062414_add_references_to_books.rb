class AddReferencesToBooks < ActiveRecord::Migration[5.2]
  def change
    add_reference :books, :user, foreign_key: true, null: false
  end
end
