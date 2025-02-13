class Seed
  def self.run
    create_posts
  end

  def self.create_posts
    puts "Creating posts..."

    10.times do |i|
      title = Faker::Book.title
      slug = title.parameterize

      Post.create!(
        title: title,
        content: Faker::Lorem.paragraphs(number: 5).join("\n\n"),
        excerpt: Faker::Lorem.paragraph(sentence_count: 2),
        slug: slug,
        authors: [
          {
            name: Faker::Name.name,
            email: Faker::Internet.email,
            bio: Faker::Lorem.paragraph
          }
        ],
        tags: [
          Faker::Book.genre,
          Faker::Book.genre
        ].uniq,
        meta_data: {
          description: Faker::Lorem.sentence,
          keywords: Faker::Lorem.words(number: 5)
        },
        published_at: Faker::Time.between(from: 2.years.ago, to: Time.current),
        ghost_id: SecureRandom.uuid
      )

      puts "Created post #{i + 1} of 10: #{title}"
    end

    puts "Finished creating posts!"
  end
end

Seed.run
