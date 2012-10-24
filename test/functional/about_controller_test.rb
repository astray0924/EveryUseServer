require 'test_helper'

class AboutControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get publication" do
    get :publication
    assert_response :success
  end

  test "should get faq" do
    get :faq
    assert_response :success
  end

end
