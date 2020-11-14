# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  display     :boolean          default(FALSE)
#  name        :string(255)      not null
#  price       :integer          not null
#  text        :text(65535)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  admin_id    :bigint           not null
#  category_id :integer          not null
#
# Indexes
#
#  index_products_on_admin_id  (admin_id)
#
# Foreign Keys
#
#  fk_rails_...  (admin_id => admins.id)
#
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
