# frozen_string_literal: true

class NotificationSetting < ApplicationRecord
  belongs_to :user

  validates :day, inclusion: [true, false]
  validates :week, inclusion: [true, false]
  validates :month, inclusion: [true, false]
end
