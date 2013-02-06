class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :publisher
      t.string :edition
      t.string :isbn
      t.integer :year

      t.timestamps
    end
  end
end
