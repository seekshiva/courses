class AddAboutToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :about, :text
  end
end
