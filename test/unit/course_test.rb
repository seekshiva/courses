require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test "course attributes must not be null" do
    course = Course.new
    assert course.invalid?
    assert course.errors[:subject_code].any?
    assert course.errors[:name].any?
    assert course.errors[:about].any?
  end
end
