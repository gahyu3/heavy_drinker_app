# frozen_string_literal: true

class RanksController < ApplicationController
  def index
    period = params[:period] || 'month'
    favorite_users = params[:favorite_users]
    @ranks = case period
              when 'month'
                if favorite_users == '1'
                  current_user.followings.rank_for_month
                else
                  User.rank_for_month
                end
              when 'week'
                if favorite_users == '1'
                  current_user.followings.rank_for_week
                else
                  User.rank_for_week
                end
              when 'day'
                if favorite_users == '1'
                  current_user.followings.rank_for_day
                else
                  User.rank_for_day
                end
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
