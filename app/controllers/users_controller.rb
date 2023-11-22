class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: "登録に成功しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    @records = current_user.records.where(date: Date.today.beginning_of_month..Date.today.end_of_month)
    @chart_data = {}
    
    @records.each do |record|
      date_key = record.date.strftime('%Y/%m/%d')
      @chart_data[date_key] ||= 0
      @chart_data[date_key] += (record.quantity * record.drink.volume * record.drink.degree / 100 * 0.8)
    end

    @alcohol = []
    
    @drinks = Drink
    .joins(:records)
    .select('drinks.*,sum(records.quantity) as tortal_quantity')
    .group('drinks.id')
    .where(records: { date: Date.today.beginning_of_month..Date.today.end_of_month, user_id: current_user.id })
    
    @drinks.each do |drink|
      @alcohol << (drink.tortal_quantity * drink.volume * drink.degree/100 * 0.8).round
    end

    @tortal_alcohol = @alcohol.sum
    
    @category_date = []

    (1..Category.count).each do |index|
      categories = Drink
      .joins(:records, :category)
      .select('drinks.*,sum(records.quantity) as tortal_quantity,categories.name as category_name')
      .group('drinks.id', 'categories.id')
      .where(records: { date: Date.today.beginning_of_month..Date.today.end_of_month, user_id: current_user.id }, category_id: index)
      
        categories.each do |category|
          category_amount = (category.tortal_quantity * category.volume * category.degree / 100 * 0.8).round
          @category_date << { category_name: category.category_name, tortal_amount: category_amount }
        end
    end

    @category_totals = @category_date.group_by { |item| item[:category_name].to_sym }.transform_values { |items| items.sum { |item| item[:tortal_amount] } }

  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
