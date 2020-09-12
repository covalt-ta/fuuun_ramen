FactoryBot.define do
  factory :product_topping do
    association :product, strategy: :create
  end
end
