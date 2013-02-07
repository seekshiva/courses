class CreateCourseReferences < ActiveRecord::Migration
  def change
    create_table :course_references do |t|
      t.references :course
      t.references :book

      t.timestamps
    end
    add_index :course_references, :course_id
    add_index :course_references, :book_id
  end
end
