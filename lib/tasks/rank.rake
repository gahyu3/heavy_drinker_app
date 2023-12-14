namespace :rank do
  desc "am9時に前日のお酒の量を集計"
    task rank_day: :environment do
      rank_day = User.rank_day_user
      rank_day.each do |day|
        Notification.create(rank: day.user_rank, period: :day,start_date: Date.yesterday.beginning_of_day, end_date: Date.yesterday.beginning_of_day, user_id: day.id) if day.day?
      end
    end

  desc "週間終わりのam9時にお酒の量を集計"
    task rank_week: :environment do
      rank_week = User.rank_week_user
      rank_week.each do |week|
        Notification.create(rank: week.user_rank, period: :week, start_date: Date.yesterday.beginning_of_week, end_date: Date.yesterday.end_of_week, user_id: week.id) if week.week?
      end
    end

  desc "月の最終日のam9時にお酒の量を集計"
    task rank_month: :environment do
      rank_month = User.rank_month_user
      rank_month.each do |month|
        Notification.create(rank: month.user_rank, period: :month, start_date: Date.yesterday.beginning_of_month, end_date: Date.yesterday.end_of_month, user_id: month.id) if month.month?
      end
    end

  desc "10日過ぎた通知は削除" 
    task delete_notifications: :environment do
      Notification.notifications_destroy
    end
end