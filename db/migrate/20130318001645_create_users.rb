class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.references :department
      t.boolean :activated

      t.timestamps
    end
    add_index :users, :department_id
  end
end
