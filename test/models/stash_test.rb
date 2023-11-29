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

  test "should generate a uuid" do
    stash = FactoryBot.create(:stash)
    assert stash.uuid.present?
  end

  test "should generate a unique uuid" do
    stash1 = FactoryBot.create(:stash)
    stash2 = FactoryBot.create(:stash)
    assert stash1.uuid != stash2.uuid
  end
end
