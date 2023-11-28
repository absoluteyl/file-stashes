require 'test_helper'

class StashTest < ActiveSupport::TestCase
  test "should be valid" do
    stash = Stash.new
    stash.attachment.attach(io: File.open('test/fixtures/files/stash_attachment.txt'), filename: 'stash_attachment.txt', content_type: 'text/plain')
    assert stash.valid?
  end
end
