# frozen_string_literal: true
class TmdbController < ApplicationController
  skip_before_action :authenticate_request

  def find
    render json: Tmdb::Search.movie(params[:name])
  end

  # Params: @for => word to search for
  def search
    unless params[:for].present?
      render json: { response: "Parameter 'for' not present " }, status: :bad_request
    end

    begin
      response = Tmdb::Search.multi(params[:for])[:results]

      response.each do |movie|
        next if Movie.exists?(movie[:id])  # Does not exist in our DB
          
        movie_details = get_detail(movie[id])
        save_movie(movie_details)
        render json: { response: response }, status: :ok
      end
    end

    rescue StandardError
      render json: { response: 'A problem occurred' }, status: :internal_server_error
  end

  def in_theatre
    begin
      render json: { response: Tmdb::Movie.now_playing }, status: :ok
    end

    rescue StandardError
      render json: { response: 'A problem occurred' }, status: :internal_server_error
  end

  def popular
    api_response = Tmdb::Movie.popular

    api_response.each do |movie|
      save_movie(movie) unless Movie.exists?(id: movie[:id])
    end

    render json: { response: api_response }, status: :ok
  end

  def detail
    render json: Tmdb::Movie.detail(params[:id])
  end

  def save_stars
    status = save_stars_page(1)
    (2..10).each do |i|
      status &&= save_stars_page(i)
    end

    if status
      render json: { response: Star.all }, status: 200
    else
      render json: { response: 'A failure occurred while saving the stars' }, status: 500
    end
  end

  def save_genres
    genres = Tmdb::Genre.movie_list

    genres.each do |genre|
      genre = Genre.create(id: genre[:id], name: genre[:name])
      genre.save
    end
  end

  def save_popular_movies
    (1..10).each do |i|
      save_movies_page(i)
    end

    render json: Movie.all,
           status: 200
  end

  private

  def save_stars_page(page)
    people = Tmdb::Person.popular(page: page)

    people[:results].each do |person|
      gender = person[:gender] == 2 ? 'Male' : 'Female'
      star = Star.create(id: person[:id], name: person[:name],
                         photo: person[:profile_path], gender: gender)
      star_entry = star.save

      next unless star_entry # Star is successfully saved
      star_movies = person[:known_for]

      star_movies.each do |movie|
        unless Movie.exists?(id: movie[:id]) # This movie does not exist in our DB
          movie_detail = get_detail(movie[:id]) # Fetch and save the movie first

          if movie_detail.nil?
            next
          else
            save_movie(movie_detail)
          end
        end

        movie_entry = Movie.find_by_id(movie[:id])

        next if movie_entry.nil?
        movie_entry.stars << star
        star.movies << movie_entry
        MovieStar.create(movie_id: movie_entry[:id], star_id: star[:id])
      end
    end

    true
  end

  def save_movies_page(page)
    search = Tmdb::Movie.popular(page: page)

    # Add every movie in page to DB
    search[:results].each do |result|
      id = result[:id]
      details = get_detail(id)

      next if details.nil?
      save_movie(details) unless Movie.exists?(id: id)
    end

  end

  def save_movie(details)
      movie = Movie.create(id: details[:id], title: details[:original_title],
                           released: details[:release_date], runtime: details[:runtime],
                           plot: details[:overview], language: details[:original_language],
                           vote_average: details[:vote_average], revenue: details[:revenue],
                           poster_path: details[:poster_path], budget: details[:budget])

      genres = details[:genres]

      genres.each do |genre|
        saved_genre = Genre.find_by_id(genre[:id])
        saved_movie = Movie.find_by_id(details[:id])
        saved_genre.movies << saved_movie
      end

      movie.save
      movie[:id]
  end

  def get_detail(id)
      Tmdb::Movie.detail(id)

      rescue Exception
  end
end

