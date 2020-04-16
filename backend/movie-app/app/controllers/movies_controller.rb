class MoviesController < ApplicationController
  skip_before_action :authenticate_request, raise: false

  def index
    @movies = Movie.all

    render :json => @movies
  end

  def show

    if Movie.exists?(params[:id])
      @movie = Movie.find_by_id(params[:id])
    else
      @movie = Tmdb::Movie.detail(params[:id])
      save_movie(@movie)
    end

    render :json => @movie
  end


  private

  def save_movie(details)
    movie = Movie.create(id: details[:id], title: details[:original_title],
                         released: details[:release_date], runtime: details[:runtime],
                         plot: details[:overview], language: details[:original_language],
                         vote_average: details[:vote_average], revenue: details[:revenue],
                         poster_path: details[:poster_path], budget: details[:budget])

    genres = details[:genres]

    genres.each do |genre|
      movie.genres << genre
    end

    movie.save
    movie[:id]
end

end
