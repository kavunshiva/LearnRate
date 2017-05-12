class ReviewsController < ApplicationController

  before_action :authorize_user

  def index
    @reviews = Review.all.sort_by { |review| review.lesson.unit_location }
  end

  def new
    @review = Review.new(lesson_id: params[:lesson_id])
  end

  def create
    @review = Review.new(review_params(:comment))
    @review.user = current_user
    @review.lesson = Lesson.find_by(id: params[:review][:lesson_id])
    @rating = Rating.new(rating_params(:quality, :helpfulness, :frustration, :time_taken, :time_taken_minutes, :time_taken_hours))
    @rating.time_taken = @rating.hours_minutes_to_minutes
    @tag = Tag.new(progress: params[:review][:tag][:progress])
    @review.rating = @rating
    @review.tag = @tag
    if @review.save
      redirect_to @review
    else
      render :new
    end
  end

  def show
    @review = Review.find_by(id: params[:id])
  end

  def edit
    review = Review.find_by(id: params[:id])
    if session[:user_id] == review.user.id || current_user.admin
      @review = review
    else
      flash[:notice] = "You must be either be the user who created this review or the admin to edit this review."
      redirect_to reviews_path
    end
  end

  def update

    @review = Review.find_by(id: params[:id])
    @review.comment = params[:review][:comment]
    @review.user = current_user
    @review.lesson = Lesson.find_by(id: params[:review][:lesson_id])
    @review.rating.update(rating_params(:quality, :helpfulness, :frustration, :time_taken_minutes, :time_taken_hours))
    @review.rating.time_taken = @review.rating.hours_minutes_to_minutes

    @review.tag.update(progress: params[:review][:tag][:progress])
    if @review.save
      @review.rating.save
      redirect_to @review
    else
      render :edit
    end
  end

  private

  def review_params(*args)
    params.require(:review).permit(*args)
  end

  def rating_params(*args)
    params.require(:review).require(:rating).permit(*args)
  end

  def tap_params(*args)
    params.require(:review).require(:tag).permit(*args)
  end

end
