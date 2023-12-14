class ApplicationController < ActionController::Base
  before_action :require_login
  before_action -> { notifications if logged_in? }
  add_flash_types :success, :info, :warning, :danger

  private

  def not_authenticated
    redirect_to login_path, warning: "ログインしてください"
  end

  def notifications
    @user_rank = current_user.notifications.order(created_at: :desc).limit(10).reverse
  end

end
