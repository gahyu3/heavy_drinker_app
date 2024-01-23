class FollowsController < ApplicationController

  def create
      user = User.find(params[:user_id])
      current_user.active_follow.create(followed: user)
      redirect_to users_path
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.active_follow.find_by(followed_id: user).destroy
    redirect_to users_path
  end

  def followings
    user = User.find(params[:user_id])
    @follow = user.active_follow.map(&:followed)
  end

  
end
