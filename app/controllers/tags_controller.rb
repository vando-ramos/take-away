class TagsController < ApplicationController
  before_action :set_establishment
  before_action :set_tag, only: %i[edit update]

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

  def edit
  end

  def update
    if @tag.update(tag_params)
      redirect_to establishment_tags_path(@establishment.id), notice: 'Tag successfully updated'
    else
      flash.now.alert = 'Unable to update tag'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_establishment
    @establishment = current_user.establishment

    if @establishment.nil? || @establishment.id.to_s != params[:establishment_id]
      return redirect_to establishment_tags_path(@establishment.id),
      alert: 'Not found or access not authorized'
    end
  end

  def set_tag
    @tag = Tag.find_by(id: params[:id])

    if @tag.nil? || !(@tag.dishes.exists?(establishment: @establishment))
      return redirect_to establishment_tags_path(@establishment.id),
      alert: 'Not found or access not authorized'
    end
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
