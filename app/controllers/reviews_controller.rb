class ReviewsController < ApplicationController

  before_action :authorize_user

  def index
    @reviews = Review.all.sort_by { |review| review.lesson.unit_location }
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params(:comment))
    @review.user = current_user
    @review.lesson = Lesson.find_by(id: params[:review][:lesson_id])
    @rating = Rating.new(rating_params(:quality, :helpfulness, :frustration, :time_taken))
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
    @review = Review.find_by(id: params[:id])
  end

  def update
    @review = Review.find_by(id: params[:id])
    @review.comment = params[:review][:comment]
    @review.user = current_user
    @review.lesson = Lesson.find_by(id: params[:review][:lesson_id])
    @review.rating.update(rating_params(:quality, :helpfulness, :frustration, :time_taken))
    @review.tag.update(progress: params[:review][:tag][:progress])
    if @review.save
      redirect_to @review
    else
      render :new
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
