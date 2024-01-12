# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user

  validates :rank, presence: true
  validates :period, presence: true
  validates :check, inclusion: [true, false]

  enum period: { day: 0, week: 1, month: 2 }

  def self.notifications_destroy
    where('created_at < ?', Date.today - 10).delete_all
  end
end
