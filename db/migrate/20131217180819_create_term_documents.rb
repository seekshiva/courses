class CreateTermDocuments < ActiveRecord::Migration
  def change
    create_table :term_documents do |t|
      t.reference :document
      t.reference :term

      t.timestamps
    end
  end
end
