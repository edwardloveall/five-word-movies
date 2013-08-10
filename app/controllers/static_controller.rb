class StaticController < ApplicationController
  def welcome
    @first_movie = Movie.first
  end
end
