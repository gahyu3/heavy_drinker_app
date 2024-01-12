# frozen_string_literal: true

FactoryBot.define do
  factory :drink do
    sequence(:name) { |n| "飲み物#{n}" }
    degree { 5 }
    volume { 500 }
    association :user
    association :category
  end
end
