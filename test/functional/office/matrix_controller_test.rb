require 'test_helper'

class Office::MatrixControllerTest < ActionController::TestCase
  test "should get monitor" do
    get :monitor
    assert_response :success
  end

  test "should get level" do
    get :level
    assert_response :success
  end

  test "should get upline" do
    get :upline
    assert_response :success
  end

  test "should get downline" do
    get :downline
    assert_response :success
  end

end
