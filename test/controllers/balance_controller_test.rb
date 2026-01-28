require "test_helper"

class BalanceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get balance_index_url
    assert_response :success
  end
end
