class MoviesController < ApplicationController
  skip_before_action :authenticate_request, raise: false

  def index
    @movies = Movie.all

    render :json => @movies
  end
end
