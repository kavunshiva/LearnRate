class TagsController < ApplicationController

  before_action :authorize_user

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tags_params)
    if @tag.save
      redirect_to @tag
    else
      render :new
    end
  end

  def show
    @tag = Tag.find_by(id: params[:id])
  end

  def edit

    @tag = Tag.find_by(id: params[:id])

    if @tag.helper_username.nil?
      @tag.helper_username = current_user.username
    else
      @tag.helper_username = nil
    end

    @tag.save
    redirect_to '/help'

  end

  def update
    @tag = Tag.find_by(id: params[:id])

    if @tag.helper_username.nil?
      @tag.helper_username = current_user.username
    else
      @tag.helper_username = nil
    end

    @tag.save
    redirect_to tags_path
  end

  private

  def tags
    params.require(:tag).permit(:progress)
  end

end
