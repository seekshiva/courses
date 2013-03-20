class CreateCourseFaculties < ActiveRecord::Migration
  def change
    create_table :course_faculties do |t|
      t.references :course
      t.references :faculty

      t.timestamps
    end
    add_index :course_faculties, :course_id
    add_index :course_faculties, :faculty_id
  end
end
