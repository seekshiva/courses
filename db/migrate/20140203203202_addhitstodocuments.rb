class Addhitstodocuments < ActiveRecord::Migration
  def up
    add_column :documents, :no_of_hits, :integer, :default => 0
  end
  def down
    remove_column :documents, :no_of_hits
  end
end
