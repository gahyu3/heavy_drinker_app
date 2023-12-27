class RecordsController < ApplicationController
  
  def index; end

  def new
    if params[:selected_date].present?
      session[:selected_date] = params[:selected_date]
    end
    @day_date = Date.parse(session[:selected_date])
    
    @record = Record.new
    @records = current_user.records
    @category = Category.all
    @selected_category_id = params[:category_id] || Category.first.id

    if params[:category_id]
      category = Category.find(params[:category_id]) 
      @drinks = category.drinks
    else
      @drinks = current_user.drinks.where(drinks: {category_id: 1})
    end


    # @drink = Category.find(params[:id]).drinks
    # respond_to do |format|
    #   format.turbo_stream
    #   format.html { redirect_to root_path } # もしJavaScriptが無効な場合のフォールバック
    # end

    # if params[:category_id].present?
    #   # 選択されたカテゴリーに応じたお酒を取得
    #   @drinks = Drink.where(category_id: params[:category_id])
    # else
    #   @drinks = Drink.all
    # end
  
    # respond_to do |format|
    #   format.html 
    #   format.turbo_stream do
    #     render turbo_stream: turbo_stream.replace('drinks_list', partial: 'records/list', locals: { drinks: @drinks })
    #   end
    # end


    
  end

  def create
    
    record_params[:record].each do |record_data|
      existing_record = current_user.records.find_by(date: record_data["date"], drink_id: record_data["drink_id"])

      if existing_record

        existing_record.update(quantity: record_data["quantity"].to_i)
      else
        current_user.records.create(date: record_data["date"], drink_id: record_data["drink_id"], quantity: record_data["quantity"].to_i)
      end
    end
    redirect_to records_path, success: "記録しました"
      
  end
  
  def edit
    if params[:selected_date].present?
      session[:selected_date] = params[:selected_date]
    end
    @day_date = session[:selected_date]

    @record = current_user.records.where(date: @day_date)

  end


  private

  def record_params
    params.require(:record).permit(record: [:date, :drink_id, :quantity])
  end

end
