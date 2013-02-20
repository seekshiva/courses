class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.references :term
      t.date :date
      t.string :time
      t.string :room

      t.timestamps
    end
    add_index :classrooms, :term_id
  end
end
