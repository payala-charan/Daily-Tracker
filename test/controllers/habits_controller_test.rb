require "test_helper"

class HabitsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get habits_index_url
    assert_response :success
  end

  test "should get new" do
    get habits_new_url
    assert_response :success
  end

  test "should get edit" do
    get habits_edit_url
    assert_response :success
  end
end
