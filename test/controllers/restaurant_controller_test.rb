require 'test_helper'

class RestaurantControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get restaurant_top_url
    assert_response :success
  end

end
