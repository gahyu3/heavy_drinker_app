# frozen_string_literal: true

FactoryBot.define do
  factory :record do
    date { '2023-11-01' }
    quantity { 1 }
    association :drink
    user { drink.user }
  end
end
