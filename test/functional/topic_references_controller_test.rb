require 'test_helper'

class TopicReferencesControllerTest < ActionController::TestCase
  setup do
    @topic_reference = topic_references(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:topic_references)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create topic_reference" do
    assert_difference('TopicReference.count') do
      post :create, topic_reference: { references: @topic_reference.references }
    end

    assert_redirected_to topic_reference_path(assigns(:topic_reference))
  end

  test "should show topic_reference" do
    get :show, id: @topic_reference
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @topic_reference
    assert_response :success
  end

  test "should update topic_reference" do
    put :update, id: @topic_reference, topic_reference: { references: @topic_reference.references }
    assert_redirected_to topic_reference_path(assigns(:topic_reference))
  end

  test "should destroy topic_reference" do
    assert_difference('TopicReference.count', -1) do
      delete :destroy, id: @topic_reference
    end

    assert_redirected_to topic_references_path
  end
end
