class Post < ApplicationRecord
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :ghost_id, presence: true, uniqueness: true

  scope :published, -> { where.not(published_at: nil) }
end

# == Schema Information
#
# Table name: posts
#
#  id            :integer          not null, primary key
#  title         :string           not null
#  content       :text
#  excerpt       :string
#  feature_image :string
#  slug          :string           not null
#  authors       :json
#  tags          :json
#  meta_data     :json
#  published_at  :datetime
#  ghost_id      :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_posts_on_ghost_id  (ghost_id) UNIQUE
#  index_posts_on_slug      (slug) UNIQUE
#
