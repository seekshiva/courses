require 'test_helper'

class TopicDocumentsControllerTest < ActionController::TestCase
  setup do
    @topic_document = topic_documents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:topic_documents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create topic_document" do
    assert_difference('TopicDocument.count') do
      post :create, topic_document: {  }
    end

    assert_redirected_to topic_document_path(assigns(:topic_document))
  end

  test "should show topic_document" do
    get :show, id: @topic_document
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @topic_document
    assert_response :success
  end

  test "should update topic_document" do
    put :update, id: @topic_document, topic_document: {  }
    assert_redirected_to topic_document_path(assigns(:topic_document))
  end

  test "should destroy topic_document" do
    assert_difference('TopicDocument.count', -1) do
      delete :destroy, id: @topic_document
    end

    assert_redirected_to topic_documents_path
  end
end
