class TagsController < ApplicationController
  before_action :set_establishment_and_check_user

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to establishment_tags_path(@establishment.id), notice: 'Tag successfully registered'
    else
      flash.now.alert = 'Unable to register tag'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_establishment_and_check_user
    @establishment = Establishment.find_by(id: params[:establishment_id])

    if @establishment.nil?
      return redirect_to root_path, alert: 'Establishment not found'
    elsif @establishment.user != current_user
      return redirect_to root_path,
      alert: 'You do not have access to information from other establishments'
    end
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
