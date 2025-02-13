class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content
      t.string :excerpt
      t.string :feature_image
      t.string :slug, null: false
      t.json :authors
      t.json :tags
      t.json :meta_data
      t.datetime :published_at
      t.string :ghost_id, null: false

      t.timestamps
    end
    add_index :posts, :slug, unique: true
    add_index :posts, :ghost_id, unique: true
  end
end
