require 'test_helper'

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get restaurants_top_url
    assert_response :success
  end

end
