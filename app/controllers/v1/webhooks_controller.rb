class V1::WebhooksController < ActionController::API
  def ghost
    payload = params[:post][:current]

    post = Post.find_or_initialize_by(ghost_id: payload[:id])

    post.assign_attributes(
      title: payload[:title],
      content: payload[:html],
      excerpt: payload[:custom_excerpt] || payload[:excerpt],
      feature_image: payload[:feature_image],
      slug: payload[:slug],
      authors: payload[:authors],
      tags: payload[:tags],
      meta_data: {
        meta_title: payload[:meta_title],
        meta_description: payload[:meta_description],
        og_image: payload[:og_image],
        og_title: payload[:og_title],
        og_description: payload[:og_description],
        twitter_image: payload[:twitter_image],
        twitter_title: payload[:twitter_title],
        twitter_description: payload[:twitter_description]
      },
      published_at: payload[:published_at]
    )

    if post.save
      render json: { status: "success", post: post }, status: :ok
    else
      render json: { status: "error", errors: post.errors }, status: :unprocessable_entity
    end
  end
end
