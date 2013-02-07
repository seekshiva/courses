class AddShortToBooks < ActiveRecord::Migration
  def change
    add_column :books, :short, :string
  end
end
