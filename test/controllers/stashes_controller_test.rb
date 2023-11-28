class StashesControllerTest < ActionDispatch::IntegrationTest
  test "should get stash index when accessing root url" do
    get root_url
    assert_response :success
  end

  test "index page displays stash table header" do
    get stashes_url
    assert_response :success
    assert_select 'table' do
      assert_select 'thead tr', count: 1
      assert_select 'thead tr th', text: 'ID'
      assert_select 'thead tr th', text: 'Download'
      assert_select 'thead tr th', text: 'Delete'
      assert_select 'thead tr th', text: 'Created at'
      assert_select 'thead tr th', text: 'Updated at'
    end
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
