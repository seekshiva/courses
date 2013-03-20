class CreateFaculties < ActiveRecord::Migration
  def change
    create_table :faculties do |t|
      t.references :user
      t.string :prefix
      t.string :designation

      t.timestamps
    end
    add_index :faculties, :user_id
  end
end
