class Renamecoverurl < ActiveRecord::Migration
  def up
  	remove_column :books, :cover_url
  	remove_column :books, :download_url


  	create_table :book_covers do |t|
  		t.string :url
  		t.references :book
  		t.integer :uploaded_by

  		t.timestamps
  	end

  	create_table :avatars do |t|
  		t.string :url
  		t.references :user
  		t.integer :uploaded_by

  		t.timestamps
  	end

  	create_table :files do |t|
  		t.string :url
  		t.integer :uploaded_by

  		t.timestamps
  	end

  	change_table :users do |t|
  		t.references :avatar
  	end

  	change_table :books do |t|
  		t.references :book_cover
  		t.references :file
  	end
  end

  def down
  	add_column :books, :cover_url, :string
  	add_column :books, :download_url, :string

  	drop_table :book_covers
  	drop_table :avatars
  	drop_table :files

  	change_table :users do |t|
  		t.remove :avatar
  	end

	change_table :books do |t|
  		t.remove :book_cover
  		t.remove :file
  	end

  end
end
