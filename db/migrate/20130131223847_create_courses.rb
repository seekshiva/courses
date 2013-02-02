class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :subject_code
      t.string :name
      t.integer :credits

      t.timestamps
    end
  end
end
