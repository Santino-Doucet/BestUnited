require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get orders_edit_url
    assert_response :success
  end

  test "should get update" do
    get orders_update_url
    assert_response :success
  end
end
