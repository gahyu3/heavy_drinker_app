class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new; end
    
  def create 
    @user = User.find_by_email(params[:email])
        
    @user.deliver_reset_password_instructions! if @user
        
    redirect_to root_path, success: "メールを送信しました"
  end
    
  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if @user.blank?
  end
      
  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      redirect_to root_path, success: "パスワードを変更しました"
    else
      flash.now[:danger] = "パスワード変更出来ませんでした"
      render :edit, status: :unprocessable_entity
    end
  end
  
end
