class SwapTopicsAndSections < ActiveRecord::Migration
  def change
    rename_table :sections, :section_temp_xyz
    rename_table :topics, :sections
    rename_table :section_temp_xyz, :topics

    rename_column :topics,       :topic_id, :section_id
    rename_column :class_topics, :section_id, :topic_id
    rename_column :references,   :section_id, :topic_id
  end
end
