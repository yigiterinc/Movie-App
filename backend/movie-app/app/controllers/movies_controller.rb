class MoviesController < ApplicationController
  skip_before_action :authenticate_request, raise: false

  def index
    @movies = Movie.all

    render :json => @movies
  end

  def show
    @movie = Movie.find_by_id(params[:id])

    render :json => @movie
  end
end
