class RecordsController < ApplicationController
  
  def index; end

  def new
    if params[:selected_date].present?
      session[:selected_date] = params[:selected_date]
    end
    @day_date = session[:selected_date]

    @record = Record.new
    @drinks = current_user.drinks.all
  end

  def create
    saved_records = []

    record_params[:record].each do |record_data|
      @record = current_user.records.build(date: record_data["date"], drink_id: record_data["drink_id"], quantity: record_data["quantity"].to_i)
      
      if @record.save
        saved_records << @record
      end
    end

      if saved_records.any?
        redirect_to records_path, success: "記録しました"
      end
      
  end

  def edit
    if params[:selected_date].present?
      session[:selected_date] = params[:selected_date]
    end
    @day_date = session[:selected_date]

    @record = current_user.records.where(date: @day_date)

  end

  def update

  end

  private

  def record_params
    params.require(:record).permit(record: [:date, :drink_id, :quantity])
  end


  

end
