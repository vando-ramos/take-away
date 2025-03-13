class DrinkOptionsController < ApplicationController
  before_action :authorize_admin!
  before_action :set_establishment
  before_action :set_drink
  before_action :set_drink_option, only: %i[edit update]

  def index
    drink = Drink.find(params[:drink_id])
    drink_options = drink.drink_options.select(:id, :description)
    render json: drink_options
  end

  def new
    @drink_option = @drink.options.build
    @drinks = Drink.all
  end

  def create
    @drink_option = @drink.options.build(drink_option_params)

    if @drink_option.save
      redirect_to drink_path(@drink), notice: t('notices.drink_option.registered')
    else
      flash.now.alert = t('alerts.drink_option.register_fail')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @drink_option.update(drink_option_params)
      redirect_to drink_path(@drink), notice: t('notices.drink_option.updated')
    else
      flash.now.alert = t('alerts.drink_option.update_fail')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_establishment
    @establishment = current_user.establishment
  end

  def set_drink
    @drink = Drink.find_by(id: params[:drink_id])
  end

  def set_drink_option
    @drink_option = @drink.options.find_by(id: params[:id])

    unless @drink_option
      redirect_to drink_path(@drink), alert: 'Drink option not found'
    end
  end

  def drink_option_params
    params.require(:option).permit(:drink_id, :description, :price)
  end
end
