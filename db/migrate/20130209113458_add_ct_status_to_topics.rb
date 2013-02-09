class AddCtStatusToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :ct_status, :string, :default => ""
  end
end
