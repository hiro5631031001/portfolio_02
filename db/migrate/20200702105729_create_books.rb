class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :publisher
      t.string :image
      t.bigint :isbn
      t.string :url
      t.timestamps
    end
  end
end
