class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :profile_pic
      t.references :department
      t.string :designation

      t.timestamps
    end
    add_index :users, :department_id
  end
end
