require 'test_helper'

class TermDepartmentsControllerTest < ActionController::TestCase
  setup do
    @term_department = term_departments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:term_departments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create term_department" do
    assert_difference('TermDepartment.count') do
      post :create, term_department: {  }
    end

    assert_redirected_to term_department_path(assigns(:term_department))
  end

  test "should show term_department" do
    get :show, id: @term_department
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @term_department
    assert_response :success
  end

  test "should update term_department" do
    put :update, id: @term_department, term_department: {  }
    assert_redirected_to term_department_path(assigns(:term_department))
  end

  test "should destroy term_department" do
    assert_difference('TermDepartment.count', -1) do
      delete :destroy, id: @term_department
    end

    assert_redirected_to term_departments_path
  end
end
