class UpdateSizeOfFacultyAbout < ActiveRecord::Migration
  def up
    change_table :faculties do |t|
      t.change :about, :text
    end
  end

  def down
    change_table :faculties do |t|
      t.change :about, :string
    end
  end
end
