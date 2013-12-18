require 'test_helper'

class SectionDocumentsControllerTest < ActionController::TestCase
  setup do
    @section_document = section_documents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:section_documents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create section_document" do
    assert_difference('SectionDocument.count') do
      post :create, section_document: {  }
    end

    assert_redirected_to section_document_path(assigns(:section_document))
  end

  test "should show section_document" do
    get :show, id: @section_document
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @section_document
    assert_response :success
  end

  test "should update section_document" do
    put :update, id: @section_document, section_document: {  }
    assert_redirected_to section_document_path(assigns(:section_document))
  end

  test "should destroy section_document" do
    assert_difference('SectionDocument.count', -1) do
      delete :destroy, id: @section_document
    end

    assert_redirected_to section_documents_path
  end
end
