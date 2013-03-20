require 'test_helper'

class CourseFacultiesControllerTest < ActionController::TestCase
  setup do
    @course_faculty = course_faculties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:course_faculties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course_faculty" do
    assert_difference('CourseFaculty.count') do
      post :create, course_faculty: {  }
    end

    assert_redirected_to course_faculty_path(assigns(:course_faculty))
  end

  test "should show course_faculty" do
    get :show, id: @course_faculty
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course_faculty
    assert_response :success
  end

  test "should update course_faculty" do
    put :update, id: @course_faculty, course_faculty: {  }
    assert_redirected_to course_faculty_path(assigns(:course_faculty))
  end

  test "should destroy course_faculty" do
    assert_difference('CourseFaculty.count', -1) do
      delete :destroy, id: @course_faculty
    end

    assert_redirected_to course_faculties_path
  end
end
