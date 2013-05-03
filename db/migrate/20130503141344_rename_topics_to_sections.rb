class RenameTopicsToSections < ActiveRecord::Migration

  def up
    rename_table :topics, :sections
    change_table :sections do |t|
      t.references :topic
    end
    change_table :references do |t|
      t.rename :topic_id, :section_id
      t.rename :sections, :indices
    end
    change_table :class_topics do |t|
      t.rename :topic_id, :section_id
    end

    create_table :topics do |t|
      t.references :course
      t.string :title

      t.timestamps
    end

    Section.all.each do |section|
      topic = Topic.new(
                title: section.title,
                course_id: section.course_id
                )
      topic.save
      section.topic_id = topic.id
      section.save
    end
    
  end


  def down
    drop_table :topics
    change_table :sections do |t|
      t.remove :topic_id
    end
    change_table :references do |t|
      t.rename :section_id, :topic_id
      t.rename :indices, :sections
    end
    change_table :class_topics do |t|
      t.rename :section_id, :topic_id
    end

    rename_table :sections, :topics
  end

end
