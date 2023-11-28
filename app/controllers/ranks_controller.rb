class RanksController < ApplicationController

  def index
    period = params[:period] || 'month'
    @ranks = case period
            when 'month'
              ranks_month = User
              .select('users.id, users.name, users.avatar, round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) AS total_quantity')
              .joins(records: :drink)
              .group('users.id')
              .where(records: { date: Date.today.beginning_of_month..Date.today.end_of_month })
              .order(total_quantity: :desc)
            when 'week'
              ranks_week = User
              .select('users.id, users.name, users.avatar, round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) AS total_quantity')
              .joins(records: :drink)
              .group('users.id')
              .where(records: { date: Date.today.beginning_of_week..Date.today.end_of_week })
              .order(total_quantity: :desc)
            when 'day'
              ranks_day = User
              .select('users.id, users.name, users.avatar, round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) AS total_quantity')
              .joins(records: :drink)
              .group('users.id')
              .where(records: { date: Date.today.beginning_of_day..Date.today.end_of_day })
              .order(total_quantity: :desc)
            end

    @ranks_time = case period
                when 'month'
                  [Date.today.beginning_of_month, Date.today.end_of_month]
                when 'week'
                  [Date.today.beginning_of_week, Date.today.end_of_week]
                when 'day'
                  [Date.today.beginning_of_day, Date.today.end_of_day]
                end
  end
end
