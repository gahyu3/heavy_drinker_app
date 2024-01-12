# frozen_string_literal: true

class NotificationSettingsController < ApplicationController
  def edit
    @notification_setting = current_user.notification_setting
  end

  def update
    @notification_setting = current_user.notification_setting
    return unless @notification_setting.update(notification_setting_params)

    redirect_to edit_notification_setting_path, success: t('.success')
  end

  private

  def notification_setting_params
    params.require(:notification_setting).permit(:day, :week, :month)
  end
end
