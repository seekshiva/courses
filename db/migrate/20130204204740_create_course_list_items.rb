class CreateCourseListItems < ActiveRecord::Migration
  def self.up
    create_table :course_list_items do |t|
      t.references :department
      t.references :course

      t.timestamps
    end
    add_index :course_list_items, :department_id
    add_index :course_list_items, :course_id
  end

  def self.down
    drop_table :course_list_items
  end
end
