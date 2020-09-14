FactoryBot.define do
  factory :basket do
    association :user, strategy: :create
  end
end
