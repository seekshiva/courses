class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.references :course
      t.integer :academic_year
      t.integer :semester

      t.timestamps
    end
    add_index :terms, :course_id
  end
end
