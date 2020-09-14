FactoryBot.define do
  factory :order_record do
    association :user, strategy: :create
  end
end
