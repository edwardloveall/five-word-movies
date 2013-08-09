class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = find_movie
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
      redirect_to edit_movie_path(@movie)
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
end
