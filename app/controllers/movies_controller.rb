class MoviesController < ApplicationController
  before_filter :authenticate, except: :show

  def index
    @movies = Movie.order('created_at')
  end

  def show
    if params[:id] == 'random'
      redirect_to Movie.all.sample
    else
      @movie = find_movie
      @next = @movie.next_movie
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(params[:movie])
    if @movie.save
      redirect_to movies_path
    else
      render :new
    end
  end

  def edit
    @movie = find_movie
  end

  def update
    @movie = find_movie
    if @movie.update_attributes(params[:movie])
      redirect_to movies_path
    else
      render :edit
    end
  end

  def destroy
    @movie = find_movie
    @movie.destroy

    redirect_to movies_path
  end

  private

  def find_movie
    Movie.find(params[:id])
  end

  def authenticate
    begin
      credentials = YAML.load_file("#{Rails.root}/config/credentials.yml")['basic_auth']
    rescue
      credentials = { 'user' => ENV['user'], 'pass' => ENV['pass'] }
    end

    authenticate_or_request_with_http_basic do |user, pass|
      user == credentials['user'] && pass == credentials['pass']
    end
  end
end
