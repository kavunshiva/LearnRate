class LessonsController < ApplicationController
  before_action :authorize_user
  before_action :authorize_admin, except: [:index, :show]

  def index
    @lessons = Lesson.all
    # .sort_by { |lesson| lesson.unit_location }
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)
    if @lesson.save
      redirect_to @lesson
    else
      render :new
    end
  end

  def show
    @lesson = Lesson.find_by(id: params[:id])
  end

  def edit
    @lesson = Lesson.find_by(id: params[:id])
  end

  def update
    @lesson = Lesson.find_by(id: params[:id])
    if @lesson.update(lesson_params)
      redirect_to @lesson
    else
      render :edit
    end
  end

  private

  def lesson_params
    params.require(:lesson).permit(
      :name,
      :description,
      :unit_location,
      :lesson_type,
      :url
      )
  end

end
