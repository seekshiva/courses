class CreateTopicDocuments < ActiveRecord::Migration
  def change
    create_table :topic_documents do |t|
      t.reference :document
      t.reference :topic

      t.timestamps
    end
  end
end
