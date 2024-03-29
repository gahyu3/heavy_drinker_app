# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
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
  has_many :active_follow, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
  has_many :followings, through: :active_follow, source: :followed

  scope :month, -> { where(records: { date: Date.today.beginning_of_month..Date.today.end_of_month }) }
  scope :week, -> { where(records: { date: Date.today.beginning_of_week..Date.today.end_of_week }) }
  scope :day, -> { where(records: { date: Date.today.beginning_of_day..Date.today.end_of_day }) }

  # users_controller

  def self.rank_day_user
    select('users.id,
    users.name,
    notification_settings.day,
    notification_settings.week,
    notification_settings.month,
    round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) AS total_quantity',
           'RANK() OVER (ORDER BY round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) DESC) AS user_rank')
      .joins(records: :drink)
      .joins(:notification_setting)
      .group('users.id', 'notification_settings.id')
      .where(records: { date: Date.yesterday.beginning_of_day + 9.hours..Date.today.beginning_of_day + 9.hours })
  end

  def self.rank_week_user
    select('users.id,
    users.name,
    notification_settings.day,
    notification_settings.week,
    notification_settings.month,
    round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) AS total_quantity',
           'RANK() OVER (ORDER BY round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) DESC) AS user_rank')
      .joins(records: :drink)
      .joins(:notification_setting)
      .group('users.id', 'notification_settings.id')
      .where(records: { date: Date.yesterday.beginning_of_week + 9.hours..Date.yesterday.end_of_week + 1 + 9.hours })
  end

  def self.rank_month_user
    select('users.id,
    users.name,
    notification_settings.day,
    notification_settings.week,
    notification_settings.month,
    round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) AS total_quantity', 'RANK() OVER (ORDER BY round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) DESC) AS user_rank')
      .joins(records: :drink)
      .joins(:notification_setting)
      .group('users.id', 'notification_settings.id')
      .where(records: { date: Date.yesterday.beginning_of_month + 9.hours..Date.yesterday.end_of_month + 1 + 9.hours })
  end

  def create_default_drinks
    drinks.create([
                    # ビール
                    { name: '350ml缶', volume: 350, degree: 5, category_id: 1 },
                    { name: '500ml缶', volume: 500, degree: 5, category_id: 1 },
                    { name: '中ジョッキ', volume: 400, degree: 5, category_id: 1 },
                    # ワイン
                    { name: 'グラス', volume: 120, degree: 12, category_id: 2 },
                    { name: 'ボトル', volume: 720, degree: 12, category_id: 2 },
                    # 日本酒
                    { name: '一合', volume: 180, degree: 15, category_id: 3 },
                    # 焼酎
                    { name: 'ロック', volume: 80, degree: 25, category_id: 4 },
                    { name: '水割り', volume: 180, degree: 15, category_id: 4 },
                    # ウイスキー
                    { name: 'ロック', volume: 30, degree: 43, category_id: 5 },
                    # ハイボール
                    { name: '350ml缶', volume: 350, degree: 7, category_id: 6 },
                    { name: '500ml缶', volume: 500, degree: 7, category_id: 6 },
                    { name: '中ジョッキ', volume: 400, degree: 7, category_id: 6 },
                    # 酎ハイ
                    { name: '350ml缶', volume: 350, degree: 5, category_id: 7 },
                    { name: '500ml缶', volume: 500, degree: 5, category_id: 7 },
                    # サワー
                    { name: 'グラス', volume: 300, degree: 5, category_id: 8 },
                    # ジン
                    { name: 'ロック', volume: 30, degree: 40, category_id: 9 },
                    # ウォッカ
                    { name: 'ロック', volume: 30, degree: 40, category_id: 10 },
                    # 果実酒
                    { name: 'グラス', volume: 120, degree: 8, category_id: 11 }
                  ])
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[access_count_to_reset_password_page avatar created_at crypted_password email id name
       reset_password_email_sent_at reset_password_token reset_password_token_expires_at salt updated_at]
  end

  # ranks_controller

  def self.alcohol_rank
    self
      .select('users.id,
                users.name,
                users.avatar,
                round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) AS total_quantity',
              'RANK() OVER (ORDER BY round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) DESC) AS user_rank')
      .joins(records: :drink)
      .group('users.id')
  end

  def self.volume_rank
    self
      .select('users.id,
              users.name,
              users.avatar,
              sum(records.quantity * drinks.volume) as total_volume',
              'RANK() OVER (ORDER BY sum(records.quantity * drinks.volume)desc) AS user_rank')
      .joins(records: :drink)
      .group('users.id')
  end

  def self.category_alcohol_rank(category_name)
    self
      .select('users.id,
            users.name,
            users.avatar,
            categories.id as category_id,
            categories.name as category_name,
            round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) AS total_quantity',
              'RANK() OVER (PARTITION BY categories.id ORDER BY round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) DESC) AS user_rank')
      .joins(records: { drink: :category })
      .group('users.id, categories.id')
      .where(categories: { name: category_name })
  end

  def self.category_volume_rank(category_name)
    self
      .select('users.id,
              users.name,
              users.avatar,
              sum(records.quantity * drinks.volume) as total_volume',
              'RANK() OVER (ORDER BY sum(records.quantity * drinks.volume)desc) AS user_rank')
      .joins(records: { drink: :category })
      .group('users.id, categories.id')
      .where(categories: { name: category_name })
  end

  def self.follow_alcohol_rank(user)
    self
      .select('users.id,
                users.name,
                users.avatar,
                round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) AS total_quantity',
              'RANK() OVER (ORDER BY round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) DESC) AS user_rank')
      .joins(records: :drink)
      .joins("LEFT JOIN follows ON follows.followed_id = users.id AND follows.follower_id = #{user.id}")
      .group('users.id')
      .where('users.id = ? OR follows.id IS NOT NULL', user.id)
  end

  def self.follow_volume_rank(user)
    self
      .select('users.id,
              users.name,
              users.avatar,
              sum(records.quantity * drinks.volume) as total_volume',
              'RANK() OVER (ORDER BY sum(records.quantity * drinks.volume)desc) AS user_rank')
      .joins(records: :drink)
      .joins("LEFT JOIN follows ON follows.followed_id = users.id AND follows.follower_id = #{user.id}")
      .group('users.id')
      .where('users.id = ? OR follows.id IS NOT NULL', user.id)
  end

  def self.follow_category_alcohol_rank(user, category_name)
    self
      .select('users.id,
            users.name,
            users.avatar,
            categories.id as category_id,
            categories.name as category_name,
            round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) AS total_quantity',
              'RANK() OVER (PARTITION BY categories.id ORDER BY round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) DESC) AS user_rank')
      .joins(records: { drink: :category })
      .joins("LEFT JOIN follows ON follows.followed_id = users.id AND follows.follower_id = #{user.id}")
      .group('users.id, categories.id')
      .where('users.id = ? OR follows.id IS NOT NULL', user.id)
      .where(categories: { name: category_name })
  end

  def self.follow_category_volume_rank(user, category_name)
    self
      .select('users.id,
      users.name,
      users.avatar,
      sum(records.quantity * drinks.volume) as total_volume',
              'RANK() OVER (ORDER BY sum(records.quantity * drinks.volume)desc) AS user_rank')
      .joins(records: { drink: :category })
      .joins("LEFT JOIN follows ON follows.followed_id = users.id AND follows.follower_id = #{user.id}")
      .group('users.id, categories.id')
      .where('users.id = ? OR follows.id IS NOT NULL', user.id)
      .where(categories: { name: category_name })
  end
end
