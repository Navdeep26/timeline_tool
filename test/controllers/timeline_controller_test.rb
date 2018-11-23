require 'test_helper'

class TimelineControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get timeline_create_url
    assert_response :success
  end

end
