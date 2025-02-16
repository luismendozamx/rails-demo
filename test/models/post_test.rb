require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "should have a valid factory" do
    post = build(:post)
    assert post.valid?
  end

  test "should not be valid without a title" do
    post = build(:post, title: nil)
    assert_not post.valid?
  end

  test "should not be valid without a slug" do
    post = build(:post, slug: nil)
    assert_not post.valid?
  end

  test "should not be valid without a ghost_id" do
    post = build(:post, ghost_id: nil)
    assert_not post.valid?
  end

  test "published scope should return published posts" do
    create(:post, :published)
    create(:post, :unpublished)

    assert_equal Post.published.count, 1
  end
end
