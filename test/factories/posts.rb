FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "#{Faker::Book.title} #{SecureRandom.uuid}" }
    content { Faker::Lorem.paragraphs(number: 3).join("\n\n") }
    excerpt { Faker::Lorem.paragraph }
    feature_image { Faker::Internet.url(host: "example.com", path: "/images/#{Faker::File.file_name(ext: 'jpg')}") }
    slug { "#{title&.parameterize}" }
    authors { [ { name: Faker::Name.name, email: Faker::Internet.email } ] }
    tags { [ Faker::Book.genre, Faker::Book.genre ].uniq }
    meta_data { { description: Faker::Lorem.sentence, keywords: Faker::Lorem.words(number: 5) } }
    ghost_id { Faker::Internet.uuid }

    trait :unpublished do
      published_at { nil }
    end

    trait :published do
      published_at { Faker::Time.backward(days: 365) }
    end
  end
end
