require "test_helper"

class BlogControllerTest < ActionDispatch::IntegrationTest
  setup do
    @published_post = create(:post, :published)
    @unpublished_post = create(:post, :unpublished)
  end

  test "should get index" do
    get blog_url
    assert_response :success
    assert_includes @response.body, @published_post.title
    assert_not_includes @response.body, @unpublished_post.title
  end

  test "should get show" do
    get blog_url(@published_post.slug)
    assert_response :success
    assert_includes @response.body, @published_post.title
  end

  test "should return 404 for unpublished post" do
    get blog_post_url(@unpublished_post.slug)
    assert_response :not_found
  end

  test "should return 404 for non-existent post" do
    get blog_post_url("non-existent-slug")
    assert_response :not_found
  end
end
