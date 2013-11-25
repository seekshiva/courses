class Addingdetailstotables < ActiveRecord::Migration
  def up
  	add_column :authors, :about, :string
  	add_column :books, :cover_url , :string
  	add_column :books, :download_url , :string
  	add_column :books, :online_retail_url , :string
  	add_column :faculties, :about, :string
  	add_column :users, :phone, :string
  end

  def down
  	remove_column :authors, :about
  	remove_column :books, :cover_url 
  	remove_column :books, :download_url 
  	remove_column :books, :online_retail_url 
  	remove_column :faculties, :about
  	remove_column :users, :phone
  end
end
