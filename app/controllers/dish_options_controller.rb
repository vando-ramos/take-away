class DishOptionsController < ApplicationController
  before_action :authorize_admin!
  before_action :set_establishment
  before_action :set_dish
  before_action :set_dish_option, only: %i[edit update]

  def index
    dish = Dish.find(params[:dish_id])
    dish_options = dish.dish_options.select(:id, :description)
    render json: dish_options
  end

  def new
    @dish_option = @dish.options.build
    @dishes = Dish.all
  end

  def create
    @dish_option = @dish.options.build(dish_option_params)

    if @dish_option.save
      redirect_to dish_path(@dish), notice: t('notices.dish_option.registered')
    else
      flash.now.alert = t('alerts.dish_option.register_fail')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @dish_option.update(dish_option_params)
      redirect_to dish_path(@dish), notice: t('notices.dish_option.updated')
    else
      flash.now.alert = t('alerts.dish_option.update_fail')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_establishment
    @establishment = current_user.establishment
  end

  def set_dish
    @dish = Dish.find_by(id: params[:dish_id])
  end

  def set_dish_option
    @dish_option = @dish.options.find_by(id: params[:id])

    unless @dish_option
      redirect_to dish_path(@dish), alert: 'Dish option not found'
    end
  end

  def dish_option_params
    params.require(:option).permit(:dish_id, :description, :price)
  end
end
