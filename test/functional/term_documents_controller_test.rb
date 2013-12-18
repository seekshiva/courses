require 'test_helper'

class TermDocumentsControllerTest < ActionController::TestCase
  setup do
    @term_document = term_documents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:term_documents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create term_document" do
    assert_difference('TermDocument.count') do
      post :create, term_document: {  }
    end

    assert_redirected_to term_document_path(assigns(:term_document))
  end

  test "should show term_document" do
    get :show, id: @term_document
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @term_document
    assert_response :success
  end

  test "should update term_document" do
    put :update, id: @term_document, term_document: {  }
    assert_redirected_to term_document_path(assigns(:term_document))
  end

  test "should destroy term_document" do
    assert_difference('TermDocument.count', -1) do
      delete :destroy, id: @term_document
    end

    assert_redirected_to term_documents_path
  end
end
