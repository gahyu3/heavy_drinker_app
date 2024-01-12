class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      @user.create_default_drinks
      NotificationSetting.create(user_id: @user.id)
      redirect_to records_path, success: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show

    start_date = Date.today.beginning_of_month
    end_date = Date.today.end_of_month
    date_range = (start_date..end_date).to_a

    drink_records = User
      .joins(records: :drink)
      .select('records.date, users.id, users.name, round(sum(records.quantity * drinks.volume * drinks.degree/100 * 0.8)) AS total_quantity')
      .group("users.id, records.date")
      .where(records: { date: start_date..end_date, user_id: current_user.id })

    daily_data_hash = Hash.new(0)

    drink_records.each do |record|
      daily_data_hash[record.date.strftime('%-m/%-d')] = record.total_quantity
    end

    @daily_data = date_range.map { |date| [date.strftime('%-m/%-d'), daily_data_hash[date.strftime('%-m/%-d')]] }

    @chart_data = @daily_data
    
  

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
