class StarsController < ApplicationController
  skip_before_action :authenticate_request

  def index
    render json: { response: Star.all }, status: 200
  end

  def find_movies
    star = Star.find_by_name(params[:name])
    if star.movies.length
      render json: { response: star.movies },
             status: 200
    else
      render json: { response: 'Star not found' },
             status: 404
    end
  end
end
