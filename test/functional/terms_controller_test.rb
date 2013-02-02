require 'test_helper'

class TermsControllerTest < ActionController::TestCase
  setup do
    @term = terms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:terms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create term" do
    assert_difference('Term.count') do
      post :create, term: { academic_year: @term.academic_year, semester: @term.semester }
    end

    assert_redirected_to term_path(assigns(:term))
  end

  test "should show term" do
    get :show, id: @term
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @term
    assert_response :success
  end

  test "should update term" do
    put :update, id: @term, term: { academic_year: @term.academic_year, semester: @term.semester }
    assert_redirected_to term_path(assigns(:term))
  end

  test "should destroy term" do
    assert_difference('Term.count', -1) do
      delete :destroy, id: @term
    end

    assert_redirected_to terms_path
  end
end
