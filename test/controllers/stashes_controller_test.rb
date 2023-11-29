class StashesControllerTest < ActionDispatch::IntegrationTest
  # Root Path / New Path
  test "should get stash new when accessing root url" do
    get root_url
    assert_response :success
    assert_select 'h1', text: 'Upload a file'
    assert_select 'form input[type=file]', count: 1
    assert_select 'form input[type=submit]', count: 1
  end

  # Index Path
  test "should displays stash table header" do
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

  test "should displays stash information" do
    stash = FactoryBot.create(:stash)
    get stashes_url
    assert_response :success
    assert_select 'table' do
      assert_select 'tbody tr', count: 1
      assert_select 'tbody tr td', text: stash.uuid
      assert_select 'tbody tr td a', text: 'Download'
      assert_select 'tbody tr td a', text: 'Delete'
      assert_select 'tbody tr td', text: stash.created_at.to_s
      assert_select 'tbody tr td', text: stash.updated_at.to_s
    end
  end

  # Show Path
  test "should show stash detail" do
    stash = FactoryBot.create(:stash)
    token = stash.generate_uniq_token
    get stash_path(stash.uuid)
    assert_response :success
    assert_select 'h1', text: 'Stash Detail'
    assert_select '.stash_info p', text: "File Name: #{stash.attachment.blob.filename}"
    assert_select '.stash_info p', text: "File Size: #{stash.attachment.blob.byte_size}"
    assert_select '.stash_info p', text: "File Type: #{stash.attachment.blob.content_type}"
    assert_select '.stash_info a', text: 'Download'
    assert_select '.stash_info a', text: 'Share'
    assert_select '.stash_share table thead tr th', text: 'Links Created'
    assert_select '.stash_share table tbody tr td', text: token
  end

  # Share Path
  test "should generate new token" do
    stash = FactoryBot.create(:stash)
    put share_stash_path(stash.uuid)
    assert_response :redirect
    assert_redirected_to stash_path(stash.uuid)
    assert stash.tokens.present?
  end

  test "should create stash" do
    # Create a file fixture to upload
    attachment = fixture_file_upload('stash_attachment.txt', 'text/plain')

    assert_difference('Stash.count') do
      post stashes_url, params: { stash: { attachment: attachment } }
    end

    assert_redirected_to stash_path(Stash.last.uuid)
  end

  test "should destroy stash" do
    stash = FactoryBot.create(:stash)
    assert_difference('Stash.count', -1) do
      delete stash_path(stash.uuid)
    end

    assert_redirected_to stashes_path
  end
end
