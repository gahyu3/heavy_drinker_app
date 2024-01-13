# frozen_string_literal: true

class RecordsController < ApplicationController
  before_action :set_selected_date, only: %i[new edit]
  before_action :set_day_date, only: %i[new edit]

  def index; end

  def new
    @record = Record.new
    @records = current_user.records
    @category = Category.all
    @selected_category_id = params[:category_id] || Category.first.id

    if params[:category_id]
      category = Category.find(params[:category_id])
      @drinks = current_user.drinks.where(drinks: { category_id: category })
    else
      @drinks = current_user.drinks.where(drinks: { category_id: 1 })
    end
  end

  def create
    record_params[:record].each do |record_data|
      existing_record = current_user.records.find_by(date: record_data['date'], drink_id: record_data['drink_id'])

      if existing_record

        existing_record.update(quantity: record_data['quantity'].to_i)
      else
        current_user.records.create(date: record_data['date'], drink_id: record_data['drink_id'],
                                    quantity: record_data['quantity'].to_i)
      end
    end
    redirect_to records_path, success: t('.success')
  end

  def edit
    @record = current_user.records.where(date: @day_date)
  end

  def record_destroy
    @record = current_user.records.where(date: params[:day_date])
    return unless @record.exists?

    @record.destroy_all
    redirect_to records_path, success: t('.success')
  end

  def drink_destroy
    drink = Drink.find(params[:id])

    return unless drink.destroy!

    redirect_to new_record_path, success: t('.success')
  end

  private

  def record_params
    params.require(:record).permit(record: %i[date drink_id quantity])
  end

  def set_selected_date
    session[:selected_date] = params[:selected_date] if params[:selected_date].present?
  end

  def set_day_date
    @day_date = Date.parse(session[:selected_date])
  end
end
