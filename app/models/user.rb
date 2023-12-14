class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader
  
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true

  validates :reset_password_token, uniqueness: true, allow_nil: true

  has_many :records, dependent: :destroy
  has_many :drinks, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one :notification_setting, dependent: :destroy

  def self.rank_day_user
    select('users.id, users.name, notification_settings.day, notification_settings.week, notification_settings.month, round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) AS total_quantity','RANK() OVER (ORDER BY round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) DESC) AS user_rank')
    .joins(records: :drink)
    .joins(:notification_setting)
    .group('users.id', 'notification_settings.id')
    .where(records: { date: Date.yesterday.beginning_of_day + 9.hours..Date.today.beginning_of_day + 9.hours })
  end

  def self.rank_week_user
    select('users.id, users.name, notification_settings.day, notification_settings.week, notification_settings.month, round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) AS total_quantity','RANK() OVER (ORDER BY round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) DESC) AS user_rank')
    .joins(records: :drink)
    .joins(:notification_setting)
    .group('users.id', 'notification_settings.id')
    .where(records: { date: Date.yesterday.beginning_of_week + 9.hours..Date.yesterday.end_of_week + 1 + 9.hours })
  end

  def self.rank_month_user
    select('users.id, users.name, notification_settings.day, notification_settings.week, notification_settings.month, round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) AS total_quantity','RANK() OVER (ORDER BY round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) DESC) AS user_rank')
    .joins(records: :drink)
    .joins(:notification_setting)
    .group('users.id', 'notification_settings.id')
    .where(records: { date: Date.yesterday.beginning_of_month + 9.hours..Date.yesterday.end_of_month + 1 + 9.hours })
  end

end
