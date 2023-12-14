FactoryBot.define do
  factory :notification_setting do
    day { true }
    week { true }
    month { true }
    association :user
  end
end
