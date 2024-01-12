# frozen_string_literal: true

class RanksController < ApplicationController
  def index
    period = params[:period] || 'month'
    @ranks = case period
             when 'month'
               User
             .select('users.id, users.name, round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) AS total_quantity', 'RANK() OVER (ORDER BY round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) DESC) AS user_rank')
             .joins(records: :drink)
             .group('users.id')
             .where(records: { date: Date.today.beginning_of_month..Date.today.end_of_month })
             when 'week'
               User
             .select('users.id, users.name, round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) AS total_quantity', 'RANK() OVER (ORDER BY round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) DESC) AS user_rank')
             .joins(records: :drink)
             .group('users.id')
             .where(records: { date: Date.today.beginning_of_week..Date.today.end_of_week })
             when 'day'
               User
             .select('users.id, users.name, round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) AS total_quantity', 'RANK() OVER (ORDER BY round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) DESC) AS user_rank')
             .joins(records: :drink)
             .group('users.id')
             .where(records: { date: Date.today.beginning_of_day..Date.today.end_of_day })
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
