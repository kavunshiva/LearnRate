class LessonsController < ApplicationController
  before_action :authorize_user
  before_action :authorize_admin, except: [:index, :show, :search]

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

  def search
    # @lessons = Lesson.where(
    #   "name REGEXP ?",
    #   params[:search_term].split.collect {|word| "(#{word})"}.join
    # )

    # kludge - SQLite3 doesn't have REGEXP
    @lessons = find_matching_lessons(params)

    if @lessons.present?
      render :index
    else
      flash[:notice] = "Can't find that lesson. \
        Perhaps you'll find what you're looking for here?"
      redirect_to lessons_path
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

  def find_matching_lessons(params)
    all_matching_lessons = []
    params[:search_term].split.each do |term|
      lessons = Lesson.where("name LIKE ?", "%#{term}%").collect do |lesson|
        lesson
      end
      all_matching_lessons << lessons
    end
    all_matching_lessons.flatten.uniq
  end

end
