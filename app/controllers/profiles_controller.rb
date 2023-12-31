class ProfilesController < ApplicationController
  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to edit_profile_path, success: "更新しました"
    else
      flash.now[:danger] = "更新失敗"
      render :edit, status: :unprocessable_entity
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :avatar, :avatar_cache )
  end
end
