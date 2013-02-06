class CreateBookAuthors < ActiveRecord::Migration
  def change
    create_table :book_authors do |t|
      t.references :book
      t.references :author

      t.timestamps
    end
    add_index :book_authors, :book_id
    add_index :book_authors, :author_id
  end
end
