class RatingsController < ApplicationController

  def index
    @ratings = Rating.all.sort_by { |rating| rating.unit_location }
  end

  def new
    @rating = Rating.new
  end

  def create
    @rating = Rating.new(rating_params)
    if @rating.save
      redirect_to @rating
    else
      render :new
    end
  end

  def show
    @rating = Rating.find_by(id: params[:id])
  end

  def edit
    @rating = Rating.find_by(id: params[:id])
  end

  def update
    @rating = Rating.find_by(id: params[:id])
    if @rating.update(rating_params)
      redirect_to @rating
    else
      render :edit
    end
  end

  private

  def rating_params
    params.require(:rating).permit(
      :quality,
      :helpfulness,
      :frustration,
      :time_taken
      )
  end

end
