class OauthsController < ApplicationController
  skip_before_action :require_login
  def oauth
    # 指定されたプロバイダの認証ページにユーザーをリダイレクトさせる
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    # 既存のユーザーをプロバイダ情報を元に検索し、存在すればログイン
    if (@user = login_from(provider))
      redirect_to records_path, success: "#{provider.titleize}アカウントでログインしました"
    else
      begin
        # ユーザーが存在しない場合はプロバイダ情報を元に新規ユーザーを作成し、ログイン
        @user = create_from(provider)
        @user.create_default_drinks
        NotificationSetting.create(user_id: @user.id)
        auto_login(@user)
        redirect_to records_path, success: "#{provider.titleize}アカウントでログインしました"
      rescue StandardError
        redirect_to login_path, danger: "#{provider.titleize}アカウントでのログインに失敗しました"
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end
end
