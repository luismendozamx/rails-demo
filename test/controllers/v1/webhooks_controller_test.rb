require "test_helper"

class V1::WebhooksControllerTest < ActionDispatch::IntegrationTest
  test "creates a new post from ghost webhook" do
    post_params = {
      post: {
        current: {
          id: "ghost-123",
          title: "Test Post",
          html: "<p>Test content</p>",
          custom_excerpt: "Test excerpt",
          feature_image: "https://example.com/image.jpg",
          slug: "test-post",
          authors: [ "Author 1" ],
          tags: [ "tag1", "tag2" ],
          meta_title: "Meta Title",
          meta_description: "Meta Description",
          og_image: "https://example.com/og.jpg",
          og_title: "OG Title",
          og_description: "OG Description",
          twitter_image: "https://example.com/twitter.jpg",
          twitter_title: "Twitter Title",
          twitter_description: "Twitter Description",
          published_at: "2024-03-20T12:00:00Z"
        }
      }
    }

    assert_difference "Post.count", 1 do
      post v1_webhooks_ghost_path, params: post_params
    end

    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal "success", json_response["status"]

    post = Post.last
    assert_equal "ghost-123", post.ghost_id
    assert_equal "Test Post", post.title
    assert_equal "<p>Test content</p>", post.content
    assert_equal "Test excerpt", post.excerpt
  end

  test "updates existing post from ghost webhook" do
    existing_post = Post.create!(
      ghost_id: "ghost-123",
      title: "Old Title",
      content: "Old content",
      slug: "old-slug"
    )

    post_params = {
      post: {
        current: {
          id: "ghost-123",
          title: "Updated Title",
          html: "<p>Updated content</p>",
          slug: "updated-slug"
        }
      }
    }

    assert_no_difference "Post.count" do
      post v1_webhooks_ghost_path, params: post_params
    end

    assert_response :success
    existing_post.reload
    assert_equal "Updated Title", existing_post.title
    assert_equal "<p>Updated content</p>", existing_post.content
    assert_equal "updated-slug", existing_post.slug
  end

  test "handles invalid post data" do
    post_params = {
      post: {
        current: {
          id: "ghost-123",
          title: "Test Post",
          html: "<p>Test content</p>",
          slug: "", # Empty slug should trigger validation error
          published_at: "2024-03-20T12:00:00Z"
        }
      }
    }

    post v1_webhooks_ghost_path, params: post_params

    assert_response :unprocessable_entity
    json_response = JSON.parse(response.body)
    assert_equal "error", json_response["status"]
    assert_includes json_response["errors"].to_s, "can't be blank"
  end
end
