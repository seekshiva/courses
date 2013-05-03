class ChangeHodInDepartment < ActiveRecord::Migration
  def up
    change_table :departments do |t|
      t.remove :hod
      t.references :hod
    end
  end

  def down
    change_table :departments do |t|
      t.remove :hod_id
      t.string :hod
    end
  end
end
