class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.references :user

      t.timestamps
    end
    add_index :students, :user_id
  end
end
