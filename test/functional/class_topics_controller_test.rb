require 'test_helper'

class ClassTopicsControllerTest < ActionController::TestCase
  setup do
    @class_topic = class_topics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:class_topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create class_topic" do
    assert_difference('ClassTopic.count') do
      post :create, class_topic: {  }
    end

    assert_redirected_to class_topic_path(assigns(:class_topic))
  end

  test "should show class_topic" do
    get :show, id: @class_topic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @class_topic
    assert_response :success
  end

  test "should update class_topic" do
    put :update, id: @class_topic, class_topic: {  }
    assert_redirected_to class_topic_path(assigns(:class_topic))
  end

  test "should destroy class_topic" do
    assert_difference('ClassTopic.count', -1) do
      delete :destroy, id: @class_topic
    end

    assert_redirected_to class_topics_path
  end
end
