require 'test_helper'

class ItemVoteTest < ActiveSupport::TestCase
  test "vote should be required to have an item" do
    vote = ItemVote.new
    assert !vote.valid?
  end
end
