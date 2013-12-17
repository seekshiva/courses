class CreateSectionDocuments < ActiveRecord::Migration
  def change
    create_table :section_documents do |t|
      t.reference :document
      t.reference :section

      t.timestamps
    end
  end
end
