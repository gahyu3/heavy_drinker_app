# frozen_string_literal: true

class RanksController < ApplicationController
  def index

    period = params[:period] || 'month'
    favorite_users = params[:favorite_users]
    drinks_volume = params[:drinks_volume]
    category_name = params[:category_name]

    rank_scope = case period
                when 'month' then User.month
                when 'week'  then User.week
                when 'day'   then User.day
                else User.month 
                end

    if favorite_users == '1'
      if drinks_volume == '1'
        rank_scope = rank_scope.follow_volume_rank(current_user)
        rank_scope = rank_scope.follow_category_volume_rank(current_user, category_name) if category_name.present?
      else
        rank_scope = rank_scope.follow_alcohol_rank(current_user)
        rank_scope = rank_scope.follow_category_alcohol_rank(current_user, category_name) if category_name.present?
      end
    else
      if drinks_volume == '1'
        rank_scope = rank_scope.volume_rank
        rank_scope = rank_scope.category_volume_rank(category_name) if category_name.present?
      else
        rank_scope = rank_scope.alcohol_rank
        rank_scope = rank_scope.category_alcohol_rank(category_name) if category_name.present?
      end
    end

    @ranks = rank_scope

            
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
