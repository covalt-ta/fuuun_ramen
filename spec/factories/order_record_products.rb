FactoryBot.define do
  factory :order_record_product do
    association :product_topping, strategy: :create
    association :order_record, strategy: :create
    association :reservation, strategy: :create
  end
end
