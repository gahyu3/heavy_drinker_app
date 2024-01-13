# frozen_string_literal: true

class RanksController < ApplicationController
  def index
    period = params[:period] || 'month'
    @ranks = case period
             when 'month'
               User.rank_for_month
             when 'week'
               User.rank_for_week
             when 'day'
               User.rank_for_day
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
