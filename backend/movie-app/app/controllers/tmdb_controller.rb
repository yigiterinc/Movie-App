class TmdbController < ApplicationController
  skip_before_action :authenticate_request

  def find
    render json: Tmdb::Search.movie(params[:name])
  end

  def detail
    render json: Tmdb::Movie.detail(params[:id])
  end

  def save_stars
    status = save_stars_page(1)
    (2..10).each { |i|
      status &&= save_stars_page(i)
    }

    if status
      render json: { response: Star.all }, status: 200
    else
      render json: { response: 'A failure occurred while saving the stars' }, status: 500
    end
  end

  def save_genres
    genres = Tmdb::Genre.movie_list

    genres.each { |genre|
      genre = Genre.create(id: genre[:id], name: genre[:name])
      genre.save
    }
  end

  def save_popular_movies
    (2..10).each { |i|
      save_movies_page(i)
    }

    render json: Movie.all,
           status: 200
  end

  private

  def save_stars_page(page)
    people = Tmdb::Person.popular(page: page)

    people[:results].each do |person|
      gender = person[:gender] == 2 ? "Male" : "Female"
      star = Star.create(id: person[:id], name: person[:name],
                         photo: person[:profile_path], gender: gender)
      star_entry = star.save

      if star_entry # Star is successfully saved
        star_movies = person[:known_for]

        star_movies.each do |movie|
          unless Movie.exists?(id: movie[:id]) # This movie does not exist in our DB
            movie_detail = get_detail(movie[:id]) # Fetch and save the movie first

            if movie_detail == nil
              next
            else
              save_movie(movie_detail)
            end
          end

          movie_entry = Movie.find_by_id(movie[:id])

          unless movie_entry.nil?
            movie_entry.stars << star
            star.movies << movie_entry
            MovieStar.create(movie_id: movie_entry[:id], star_id: star[:id])
          end
        end
      end
    end

    true
  end

  def save_movies_page(page)
    search = Tmdb::Movie.popular(page: page)

    # Add every movie in page to DB
    search[:results].each { |result|
      id = result[:id]
      details = get_detail(id)
      unless details.nil?
        genres = details[:genres]

        unless Movie.exists?(id: id)
          movie_id = save_movie(details)

          genres.each { |genre|
            saved_genre = Genre.find_by_id(genre[:id])
            saved_movie = Movie.find_by_id(movie_id)
            saved_genre.movies << saved_movie
            saved_movie.genres << saved_genre
            MovieGenre.create(movie_id: movie_id, genre_id: genre[:id])
          }
        end
      end
    }

  end

  def save_movie(details)
      movie = Movie.create(id: details[:id], title: details[:original_title],
                           released: details[:release_date], runtime: details[:runtime],
                           plot: details[:overview], language: details[:original_language],
                           vote_average: details[:vote_average], revenue: details[:revenue],
                           poster_path: details[:poster_path], budget: details[:budget])

      movie.save
      movie[:id]
  end

  def get_detail(id)
    rescue
      Tmdb::Movie.detail(id)
  end
end

