class Adddoctokentousers < ActiveRecord::Migration
  def change
    add_column :users, :doc_access_token, :string
  end
end
