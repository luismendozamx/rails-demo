FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    content { Faker::Lorem.paragraphs(number: 3).join("\n\n") }
    excerpt { Faker::Lorem.paragraph }
    published_at { Faker::Time.between(from: 2.years.ago, to: Time.current) }
    slug { "#{title&.parameterize}-#{SecureRandom.hex(4)}" }
    meta_data { {
      description: Faker::Lorem.sentence,
      keywords: Faker::Lorem.words(number: 5)
    } }
    authors { [
      {
        name: Faker::Name.name,
        email: Faker::Internet.email,
        bio: Faker::Lorem.paragraph
      }
    ] }
    tags { Faker::Lorem.words(number: 3).map { |tag| { name: tag, slug: tag.parameterize } } }
    ghost_id { Faker::Alphanumeric.alphanumeric(number: 24) }

    trait :published do
      published_at { Time.current }
    end

    trait :unpublished do
      published_at { nil }
    end
  end
end
