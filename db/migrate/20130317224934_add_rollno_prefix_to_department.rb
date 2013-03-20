class AddRollnoPrefixToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :rollno_prefix, :string
  end
end
