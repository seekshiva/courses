class Topicnrefupdate < ActiveRecord::Migration
  def up
  	rename_column :references, :course_reference_id, :term_reference_id
  end

  def down
  	rename_column :references, :term_reference_id, :course_reference_id
  end
end
