FactoryBot.define do
  factory :product do
    name         { Faker::Lorem.word }
    text         { Faker::Lorem.sentence }
    price        { Faker::Number.between(from: 0, to: 999_999) }
    category_id  { 2 }
    association :admin, strategy: :create

    after(:build) do |product|
      product.image.attach(io: File.open('spec/fixtures/sample_ramen.jpg'), filename: "sample_ramen.jpg", content_type: 'image/jpg')
    end
  end
end
