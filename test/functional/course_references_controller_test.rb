require 'test_helper'

class CourseReferencesControllerTest < ActionController::TestCase
  setup do
    @course_reference = course_references(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:course_references)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course_reference" do
    assert_difference('CourseReference.count') do
      post :create, course_reference: {  }
    end

    assert_redirected_to course_reference_path(assigns(:course_reference))
  end

  test "should show course_reference" do
    get :show, id: @course_reference
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course_reference
    assert_response :success
  end

  test "should update course_reference" do
    put :update, id: @course_reference, course_reference: {  }
    assert_redirected_to course_reference_path(assigns(:course_reference))
  end

  test "should destroy course_reference" do
    assert_difference('CourseReference.count', -1) do
      delete :destroy, id: @course_reference
    end

    assert_redirected_to course_references_path
  end
end
