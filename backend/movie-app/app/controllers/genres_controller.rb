class GenresController < ApplicationController
  skip_before_action :authenticate_request, raise: false

  def index
    @genres = Genre.all

    render :json => @genres
  end

  def find_genre_movies
    name = params[:name]

    if Genre.exists?(name: name)
      genre = Genre.find_by_name(name)
      @movies = genre.movies
      render :json => @movies
    elsif render status: 404
    end
  end
end