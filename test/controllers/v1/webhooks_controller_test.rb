require "test_helper"

class V1::WebhooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = create(:post)
  end

  test "should create a new post from ghost webhook" do
    post_data = {
      id: SecureRandom.uuid,
      title: "New Post Title",
      html: "<p>Some content</p>",
      custom_excerpt: "Custom excerpt",
      feature_image: "https://example.com/image.jpg",
      slug: "new-post-title",
      authors: [ { "name" => "John Doe", "email" => "john@example.com" } ],
      tags: [ "ruby", "rails" ],
      meta_title: "Meta Title",
      meta_description: "Meta Description",
      og_image: "https://example.com/og.jpg",
      og_title: "OG Title",
      og_description: "OG Description",
      twitter_image: "https://example.com/twitter.jpg",
      twitter_title: "Twitter Title",
      twitter_description: "Twitter Description",
      published_at: Time.current
    }

    assert_difference "Post.count" do
      post v1_webhooks_ghost_path, params: { post: { current: post_data } }
    end

    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal "success", json_response["status"]

    post = Post.find_by(ghost_id: post_data[:id])
    assert_equal post_data[:title], post.title
    assert_equal post_data[:html], post.content
    assert_equal post_data[:custom_excerpt], post.excerpt
    assert_equal post_data[:feature_image], post.feature_image
    assert_equal post_data[:slug], post.slug
    assert_equal post_data[:authors], post.authors
    assert_equal post_data[:tags], post.tags
    assert_equal post_data[:meta_title], post.meta_data["meta_title"]
  end

  test "should update existing post from ghost webhook" do
    updated_data = {
      id: @post.ghost_id,
      title: "Updated Title",
      html: "<p>Updated content</p>",
      custom_excerpt: "Updated excerpt",
      feature_image: "https://example.com/updated.jpg",
      slug: "updated-title",
      authors: [ { name: "Jane Doe", email: "jane@example.com" } ],
      tags: [ "updated" ],
      published_at: Time.current
    }

    assert_no_difference "Post.count" do
      post v1_webhooks_ghost_path, params: { post: { current: updated_data } }
    end

    assert_response :success
    @post.reload
    assert_equal updated_data[:title], @post.title
    assert_equal updated_data[:html], @post.content
    assert_equal updated_data[:custom_excerpt], @post.excerpt
  end

  test "should handle invalid post data" do
    invalid_data = {
      id: SecureRandom.uuid,
      title: "", # Title is required
      html: "<p>Some content</p>",
      slug: "" # Slug is required
    }

    assert_no_difference "Post.count" do
      post v1_webhooks_ghost_path, params: { post: { current: invalid_data } }
    end

    assert_response :unprocessable_entity
    json_response = JSON.parse(response.body)
    assert_equal "error", json_response["status"]
    assert json_response["errors"].present?
  end
end
