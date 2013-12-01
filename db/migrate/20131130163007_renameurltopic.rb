class Renameurltopic < ActiveRecord::Migration
  def up
  	remove_column :avatars, :url
    add_attachment :avatars, :pic
    remove_column :book_covers, :url
    add_attachment :book_covers, :cover
    remove_column :files, :url
    add_attachment :files, :file
    remove_column :avatars, :uploaded_by
    remove_column :avatars, :user_id
    remove_column :book_covers, :book_id
  end

  def down
    add_column :avatars, :url, :string
    remove_attachment :avatars, :pic
    add_column :book_covers, :url, :string
    remove_attachment :book_covers, :cover
    add_column :files, :url, :string
    remove_attachment :files, :file
    add_column :avatars, :uploaded_by, :int
    add_column :avatars, :user_id, :int
    add_column :book_covers, :book_id, :int
  end
end
