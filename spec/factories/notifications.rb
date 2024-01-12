# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    rank { 1 }
    period { :day }
    check { false }
    start_date { Date.today }
    end_date { Date.today }
    association :user
  end
end
