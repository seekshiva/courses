require 'test_helper'

class BookAuthorsControllerTest < ActionController::TestCase
  setup do
    @book_author = book_authors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:book_authors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book_author" do
    assert_difference('BookAuthor.count') do
      post :create, book_author: {  }
    end

    assert_redirected_to book_author_path(assigns(:book_author))
  end

  test "should show book_author" do
    get :show, id: @book_author
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @book_author
    assert_response :success
  end

  test "should update book_author" do
    put :update, id: @book_author, book_author: {  }
    assert_redirected_to book_author_path(assigns(:book_author))
  end

  test "should destroy book_author" do
    assert_difference('BookAuthor.count', -1) do
      delete :destroy, id: @book_author
    end

    assert_redirected_to book_authors_path
  end
end
