class CreateTermFaculties < ActiveRecord::Migration
  def change
    create_table :term_faculties do |t|
      t.references :term
      t.references :faculty

      t.timestamps
    end
    add_index :term_faculties, :term_id
    add_index :term_faculties, :faculty_id
  end
end
