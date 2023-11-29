require 'test_helper'

class StashTest < ActiveSupport::TestCase
  test "should be valid" do
    stash = FactoryBot.create(:stash)
    assert stash.valid?
  end
end
