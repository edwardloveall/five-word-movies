class MovieSearchController < ApplicationController
  require 'open-uri'
  require 'json'

  def show
    title = params[:query].gsub(/\s/, '+')
    limit = "&page_limit=3"
    response = open(base_query + title + limit).read

    respond_to do |format|
      format.json { render json: response }
    end
  end

  private

  def base_query
    begin
      api = YAML.load_file("#{Rails.root}/config/credentials.yml")['movie_api']
    rescue
      api = { 'api_key' => ENV['rotten_api_key'] }
    end

    "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=#{api['key']}&q="
  end
end
