FactoryBot.define do
  factory :notice do
    action { "reservation" }
    association :admin, strategy: :create
    association :reservation, strategy: :create
  end
end
