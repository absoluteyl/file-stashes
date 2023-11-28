class StashesControllerTest < ActionDispatch::IntegrationTest
  test "should get stash index when accessing root url" do
    get root_url
    assert_response :success
  end

  test "should create stash" do
    # Create a file fixture to upload
    attachment = fixture_file_upload('stash_attachment.txt', 'text/plain')

    assert_difference('Stash.count') do
      post stashes_url, params: { stash: { attachment: attachment } }
    end

    assert_redirected_to root_url
  end
end
