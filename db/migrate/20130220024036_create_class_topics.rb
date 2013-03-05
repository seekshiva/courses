class CreateClassTopics < ActiveRecord::Migration
  def change
    create_table :class_topics do |t|
      t.references :classroom
      t.references :topic

      t.timestamps
    end
    add_index :class_topics, :class_id
    add_index :class_topics, :topic_id
  end
end
