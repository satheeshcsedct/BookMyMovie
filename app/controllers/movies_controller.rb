class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show theater_details]

  def index
    @movies = Movie.running_and_upcoming.latest_screened.group_by(&:id).values.flatten.uniq
  end

  def show; end

  def theater_details
    @date = params[:date]&.to_date
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_movie
    @movie = Movie.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def movie_params
    params.require(:movie).permit(:name, :description)
  end
end
