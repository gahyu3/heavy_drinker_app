class UserSessionsController < ApplicationController

  def new; end
  
  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_back_or_to root_path, success: 'ログイン成功です'
    else
      flash.now[:danger] = 'ログインできません'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, success: 'ログアウトしました', status: :see_other
  end
end
