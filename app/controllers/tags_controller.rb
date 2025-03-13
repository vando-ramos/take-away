class TagsController < ApplicationController
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
      redirect_to tags_path, notice: t('notices.tag.registered')
    else
      flash.now.alert = t('alerts.tag.register_fail')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      redirect_to tags_path, notice: t('notices.tag.updated')
    else
      flash.now.alert = t('alerts.tag.update_fail')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_tag
    @tag = Tag.find_by(id: params[:id])

    if @tag.nil?
      redirect_to tags_path, alert: 'Not found or access not authorized'
    end
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
