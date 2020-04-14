# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_request, except: [:follow]

  def index
    @users = User.all

    render json: @users, status: :ok
  end

  def create
    @user = User.new(user_params)

    @user.save
    render json: @user, status: :created
  end

  # Takes either movie, genre or star (name) and user_id
  def follow
    check_user_id_is_present

    user = User.find_by_id(params[:user_id])

    if params[:movie].present?
      movie = Movie.find_by_title(params[:movie])

      if movie.nil?
        render json: { response: 'Movie not found' }, status: :not_found
      end

      user.movies << movie
      movie.users << user
      UserMovie.create(user_id: user.id, movie_id: movie.id)
    elsif params[:genre].present?
      genre = Genre.find_by_name(params[:genre])

      if genre.nil?
        render json: { response: 'Genre not found' }, status: :not_found
      end

      user.genres << genre
      genre.users << user
      UserGenre.create(user_id: user.id, genre_id: genre.id)
    elsif params[:star].present?
      star = Star.find_by_name(params[:star])

      if star.nil?
        render json: { response: 'Movie not found' }, status: :bad_request
      end

      star.users << user
      user.stars << star

      UserStar.create(user_id: user.id, star_id: star.id)
    end

    render json: { response: 'Done' }, status: :ok
  end

  # Requires user_id
  def genres
    check_user_id_is_present

    user = User.find_by_id(params[:user_id])

    render json: { response: user.genres },
           status: :ok
  end

  def movies
    check_user_id_is_present

    user = User.find_by_id(params[:user_id])
    render json: { response: user.movies },
           status: :ok
  end

  def stars
    check_user_id_is_present

    user = User.find_by_id(params[:user_id])
    render json: { response: user.stars },
           status: :ok
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  private

  def check_user_id_is_present
    unless params[:user_id]
      render json: { response: 'User id not present in request' }, status: :bad_request
    end
  end
end
