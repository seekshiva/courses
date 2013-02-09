class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.references :course_reference
      t.references :topic
      t.string :sections

      t.timestamps
    end
    add_index :references, :course_reference_id
    add_index :references, :topic_id
  end
end
