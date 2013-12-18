class CreateTopicDocuments < ActiveRecord::Migration
  def change
    create_table :topic_documents do |t|
      t.references :document
      t.references :topic

      t.timestamps
    end
  end
end
