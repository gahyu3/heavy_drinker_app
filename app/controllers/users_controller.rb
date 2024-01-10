class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      NotificationSetting.create(user_id: @user.id)
      redirect_to login_path, success: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    records = current_user.records.where(date: Date.today.beginning_of_month..Date.today.end_of_month)
    @chart_data = {}
    
    records.each do |record|
      date_key = record.date.strftime('%Y/%m/%d')
      @chart_data[date_key] ||= 0
      @chart_data[date_key] += (record.quantity * record.drink.volume * record.drink.degree / 100 * 0.8)
    end

    @tortal_alcohol = User
    .joins(records: :drink)
    .select('users.id, users.name,round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) AS total_quantity')
    .group("users.id")
    .where(records: { date: Date.today.beginning_of_month..Date.today.end_of_month, user_id: current_user.id })

    @category_totals =  User
    .joins(records: {drink: :category})
    .select('users.id, users.name, categories.name ,round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) AS total_quantity')
    .group("users.id,categories.name")
    .where(records: { date: Date.today.beginning_of_month..Date.today.end_of_month, user_id: current_user.id })
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
