require "test_helper"

class User::SpotifyControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_spotify_index_url
    assert_response :success
  end
end
