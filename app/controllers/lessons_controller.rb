class LessonsController < ApplicationController

  def index
    @lessons = Lesson.all
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.save
    redirect_to @lesson
  end

  def show
    @lesson = Lesson.find_by(id: params[:id])
  end

  def edit
    @lesson = Lesson.find_by(id: params[:id])
  end

  def update
    @lesson = Lesson.find_by(id: params[:id])
    @lesson.save
    redirect_to @lesson
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
