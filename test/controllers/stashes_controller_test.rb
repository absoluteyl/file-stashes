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
      assert_select 'thead tr th', text: 'UUID'
      assert_select 'thead tr th', text: 'Download'
      assert_select 'thead tr th', text: 'Delete'
      assert_select 'thead tr th', text: 'Created at'
      assert_select 'thead tr th', text: 'Updated at'
    end
  end

  test "index page displays stash information" do
    stash = FactoryBot.create(:stash)
    get stashes_url
    assert_response :success
    assert_select 'table' do
      assert_select 'tbody tr', count: 1
      assert_select 'tbody tr td', text: stash.uuid
      assert_select 'tbody tr td a', text: 'Download'
      assert_select 'tbody tr td form[action=?][method="post"]', stash_path(stash) do
        assert_select 'button[type="submit"]', text: 'Delete'
      end
      assert_select 'tbody tr td', text: stash.created_at.to_s
      assert_select 'tbody tr td', text: stash.updated_at.to_s
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

  test "should destroy stash" do
    stash = FactoryBot.create(:stash)
    assert_difference('Stash.count', -1) do
      delete stash_url(stash)
    end

    assert_redirected_to root_url
  end
end
