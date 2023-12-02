class StashesControllerTest < ActionDispatch::IntegrationTest
  # Root Path / New Path
  test "should get stash new when accessing root url" do
    get root_url
    assert_response :success
    assert_select 'h2', text: I18n.t('stash.titles.new')
    assert_select 'form[action=?]', stashes_path, method: 'post' do
      assert_select 'input[type=file]', count: 1
      assert_select 'input[type=submit]', count: 1
    end
  end

  # Index Path
  test "should displays stash table header" do
    get stashes_url
    assert_response :success
    assert_select 'h2', text: 'Stashes'
    assert_select 'table thead tr' do
      assert_select 'tr', count: 1
      assert_select 'th:nth-child(1)', text: I18n.t('stash.attributes.filename')
      assert_select 'th:nth-child(2)', text: Stash.human_attribute_name(:created_at)
      assert_select 'th:nth-child(3)', text: Stash.human_attribute_name(:updated_at)
      assert_select 'th:nth-child(4)', text: I18n.t('stash.labels.actions')
    end
  end

  test "should displays stash information" do
    stash = FactoryBot.create(:stash)
    get stashes_url
    assert_response :success
    assert_select 'table tbody tr' do
      assert_select 'tr', count: 1
      assert_select 'td:nth-child(1) a', text: stash.filename.to_s
      assert_select 'td:nth-child(2)', text: I18n.l(stash.created_at, format: :datetime_for_console)
      assert_select 'td:nth-child(3)', text: I18n.l(stash.updated_at, format: :datetime_for_console)
      assert_select 'td:nth-child(4) a', text: I18n.t('stash.buttons.download')
      assert_select 'td:nth-child(4) a', text: I18n.t('stash.buttons.delete')
    end
  end

  # Show Path
  test "should show stash detail" do
    stash = FactoryBot.create(:stash)
    token = stash.generate_uniq_token
    get stash_path(stash.uuid)
    assert_response :success
    assert_select 'h2', text: stash.filename.to_s
    assert_select '.stash-info table tbody' do
      assert_select 'tr:nth-child(1) td:nth-child(1)', text: I18n.t('stash.attributes.byte_size')
      assert_select 'tr:nth-child(1) td:nth-child(2)', text: stash.attachment.blob.byte_size.to_s
      assert_select 'tr:nth-child(2) td:nth-child(1)', text: I18n.t('stash.attributes.content_type')
      assert_select 'tr:nth-child(2) td:nth-child(2)', text: stash.attachment.blob.content_type.to_s
    end
    assert_select '.stash-info a', text: I18n.t('stash.buttons.download')
    assert_select '.stash-info a', text: I18n.t('stash.buttons.share')
    assert_select '.stash-share h4', text: I18n.t('stash.labels.share_links')
    assert_select '.stash-share table tbody tr td a', text: Stash.share_link(token)
  end

  # Share Path
  test "should generate new token" do
    stash = FactoryBot.create(:stash)
    put share_stash_path(stash.uuid)
    assert_response :redirect
    assert_redirected_to stash_path(stash.uuid)
    assert stash.tokens.present?
  end

  # Create Path
  test "should create stash" do
    # Create a file fixture to upload
    attachment = fixture_file_upload('stash_attachment.txt', 'text/plain')

    assert_difference('Stash.count') do
      post stashes_url, params: { stash: { attachment: attachment } }
    end

    assert_redirected_to stash_path(Stash.last.uuid)
  end

  # Destroy Path
  test "should destroy stash" do
    stash = FactoryBot.create(:stash)
    assert_difference('Stash.count', -1) do
      delete stash_path(stash.uuid)
    end

    assert_redirected_to stashes_path
  end
end
