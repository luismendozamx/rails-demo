require "test_helper"

class BlogControllerTest < ActionDispatch::IntegrationTest
  setup do
    @published_post = create(:post, :published)
    @unpublished_post = create(:post, :unpublished)
    @older_post = create(:post, :published, published_at: 2.days.ago)
    @newer_post = create(:post, :published, published_at: 1.day.ago)
  end

  test "index should display all published posts" do
    get blog_url
    assert_response :success

    assert_includes @response.body, @newer_post.title
    assert_includes @response.body, @older_post.title
    assert_includes @response.body, @published_post.title
    assert_not_includes @response.body, @unpublished_post.title
  end

  test "index should display posts in descending order by published date" do
    get blog_url
    assert_response :success

    newer_pos = @response.body.index(@newer_post.title)
    older_pos = @response.body.index(@older_post.title)
    published_pos = @response.body.index(@published_post.title)

    assert newer_pos < older_pos, "Newer post should appear before older post"
    assert older_pos < published_pos, "Older post should appear before published post"
  end

  test "show should display published post" do
    get blog_post_url(@published_post.slug)
    assert_response :success
    assert_includes response.body, @published_post.title
  end

  test "show should not display unpublished post" do
    get blog_post_url(@unpublished_post.slug)
    assert_response :not_found
  end

  test "show should return 404 for invalid slug" do
    get blog_post_url("invalid-slug")
    assert_response :not_found
  end
end
