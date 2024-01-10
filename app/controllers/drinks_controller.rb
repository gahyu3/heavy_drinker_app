class DrinksController < ApplicationController
  
  def new
    @drink = Drink.new
    @day_date = session[:selected_date]
    @selected_category_id = params[:selected_category]
  end
  
  def create
    day_date = session[:selected_date]
    @drink = current_user.drinks.build(drink_params)
    
    if @drink.save
      redirect_to new_record_path(selected_date: day_date), success:  t('.success')
    else
      flash.now[:danger] =  t('.fail')
      render :new, status: :unprocessable_entity
    end
    
  end

  def destroy
    @drink = current_user.drinks.find(params[:id])
    @deink.destroy!
    redirect_to 
  end

  private

  def drink_params
    params.require(:drink).permit(:name, :degree, :volume, :category_id)
  end

end
