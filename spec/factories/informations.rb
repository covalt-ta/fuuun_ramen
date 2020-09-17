FactoryBot.define do
  factory :information do
    title       { Faker::Lorem.word }
    text        { Faker::Lorem.sentence }
    association :admin, strategy: :create

    after(:build) do |product|
      product.image.attach(io: File.open('spec/fixtures/sample_ramen.jpg'), filename: "sample_ramen.jpg", content_type: 'image/jpg')
    end
  end
end
