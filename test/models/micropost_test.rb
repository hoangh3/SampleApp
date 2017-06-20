require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = users(:hoang)
    @micropost = @user.microposts.build(content: "Clash of Clans")
  end

  test "should be vaild" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content max 140 characters" do
    @micropost.content = "a" * 142
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    assert_equal microposts(:LoL), Micropost.first
  end
end
