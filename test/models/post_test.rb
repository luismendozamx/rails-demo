require "test_helper"

class PostTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  test "should build a valid post" do
    post = FactoryBot.build(:post)
    assert post.valid?
  end

  test "should not build a post without a title" do
    post = FactoryBot.build(:post, title: nil)
    assert_not post.valid?
  end

  test "should not build a post without a slug" do
    post = FactoryBot.build(:post, slug: nil)
    assert_not post.valid?
  end

  test "should not build a post without a ghost_id" do
    post = FactoryBot.build(:post, ghost_id: nil)
    assert_not post.valid?
  end

  test "published scope should return only published posts" do
    FactoryBot.create(:post, published_at: nil)
    assert_equal 0, Post.published.count

    FactoryBot.create(:post, published_at: Time.zone.now)
    assert_equal 1, Post.published.count
  end
end
