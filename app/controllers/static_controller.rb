class StaticController < ApplicationController
  def welcome
    @first_movie = Movie.find(1, order: :created_at)
  end
end
