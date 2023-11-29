require 'test_helper'

class StashTest < ActiveSupport::TestCase
  test "should not be valid without attachment" do
    stash = Stash.new
    assert_not stash.valid?
  end

  test "should be valid" do
    stash = FactoryBot.create(:stash)
    assert stash.valid?
  end
end
