class Department < ActiveRecord::Base
  attr_accessible :short, :hod, :name

  def courses
    CourseListItem.find(:department_id => self).map do |cl|
      cl.course
    end
  end
end
