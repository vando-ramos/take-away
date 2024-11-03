class TagsController < ApplicationController
  before_action :set_establishment

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

  def set_establishment
    @establishment = current_user.establishment
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
