class Addblacklist < ActiveRecord::Migration
  def up
    add_column :users, :blacklist, :boolean, :default => false
    add_column :users, :blacklist_log, :text
  end

  def down
    remove_column :users, :blacklist
    remove_column :users, :blacklist_log
  end
end
