class CreateTermDepartments < ActiveRecord::Migration
  def change
    create_table :term_departments do |t|
      t.references :term
      t.references :department

      t.timestamps
    end
    add_index :term_departments, :term_id
    add_index :term_departments, :department_id
  end
end
