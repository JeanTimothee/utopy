require "test_helper"

class HostelsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get hostels_show_url
    assert_response :success
  end
end
