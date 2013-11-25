class Renamecoursereferencestotermreferences < ActiveRecord::Migration
  def up
  	rename_table :course_references, :term_references
  end

  def down
  	rename_table :term_references, :course_references
  end
end
