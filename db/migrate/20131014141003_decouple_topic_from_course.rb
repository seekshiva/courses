class DecoupleTopicFromCourse < ActiveRecord::Migration
  def change
    remove_column :topics, :course_id #topic should only be referenced via its section
    rename_column :sections, :course_id, :term_id
  end
end
