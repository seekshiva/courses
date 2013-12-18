class CreateTermDocuments < ActiveRecord::Migration
  def change
    create_table :term_documents do |t|
      t.references :document
      t.references :term

      t.timestamps
    end
  end
end
