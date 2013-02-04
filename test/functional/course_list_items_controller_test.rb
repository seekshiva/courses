require 'test_helper'

class CourseListItemsControllerTest < ActionController::TestCase
  setup do
    @course_list_item = course_list_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:course_list_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course_list_item" do
    assert_difference('CourseListItem.count') do
      post :create, course_list_item: {  }
    end

    assert_redirected_to course_list_item_path(assigns(:course_list_item))
  end

  test "should show course_list_item" do
    get :show, id: @course_list_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course_list_item
    assert_response :success
  end

  test "should update course_list_item" do
    put :update, id: @course_list_item, course_list_item: {  }
    assert_redirected_to course_list_item_path(assigns(:course_list_item))
  end

  test "should destroy course_list_item" do
    assert_difference('CourseListItem.count', -1) do
      delete :destroy, id: @course_list_item
    end

    assert_redirected_to course_list_items_path
  end
end
