class Renamecourseidtotermid < ActiveRecord::Migration
  def up
  	change_table :course_references do |t|
  		t.rename :course_id, :term_id
  	end
  end

  def down
  	change_table :course_references do |t|
  		t.rename :term_id, :course_id
  	end
  end
end
