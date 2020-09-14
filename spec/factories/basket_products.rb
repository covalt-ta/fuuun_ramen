FactoryBot.define do
  factory :basket_product do
    association :basket, strategy: :create
    association :product_topping, strategy: :create
  end
end
