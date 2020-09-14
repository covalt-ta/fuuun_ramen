FactoryBot.define do
  factory :product_topping_relation do
    association :product_topping, strategy: :create
    association :topping, strategy: :create
  end
end
