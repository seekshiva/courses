class Renamefileattachment < ActiveRecord::Migration
  def up
  	remove_attachment :documents, :file
  	add_attachment :documents, :document
  end

  def down
  	remove_attachment :documents, :document
  	add_attachment :documents, :file
  end
end
