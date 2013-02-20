class AddVenueToTerm < ActiveRecord::Migration
  def change
    add_column :terms, :venue, :string
  end
end
