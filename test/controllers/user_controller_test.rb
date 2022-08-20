require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get user_login_url
    assert_response :success
  end

  test "should get create" do
    get user_create_url
    assert_response :success
  end

  test "should get auto_login" do
    get user_auto_login_url
    assert_response :success
  end
end
