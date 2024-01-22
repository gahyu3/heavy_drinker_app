class FollowsController < ApplicationController

  def create
      user = User.find(params[:user_id])
      current_user.active_follow.create(followed: user)
      redirect_to records_path, success: 'hehe'
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.active_follow.find_by(followed_id: user).destroy
    redirect_to records_path, warning: 'はずしました'
  end

  def followings
    user = User.find(params[:user_id])
    @follow = user.active_follow.map(&:followed)
  end

  
end
