class CreateSectionDocuments < ActiveRecord::Migration
  def change
    create_table :section_documents do |t|
      t.references :document
      t.references :section

      t.timestamps
    end
  end
end
