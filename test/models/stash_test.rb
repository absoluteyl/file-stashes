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

  test "should generate a token" do
    stash = FactoryBot.create(:stash)
    token = stash.generate_uniq_token
    assert token == stash.tokens.first
  end

  test "should generate a uniq token" do
    stash = FactoryBot.create(:stash)
    token1 = stash.generate_uniq_token
    token2 = stash.generate_uniq_token
    assert stash.tokens.count == 2
    assert token1 != token2
  end

  test "should find stash by token" do
    stash = FactoryBot.create(:stash)
    token = stash.generate_uniq_token
    assert stash == Stash.find_by_token(token)
  end
end
