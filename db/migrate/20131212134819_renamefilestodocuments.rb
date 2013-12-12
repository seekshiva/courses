class Renamefilestodocuments < ActiveRecord::Migration
  def up
  	rename_table :files, :documents
  end

  def down
  	rename_table :documents, :files
  end
end
