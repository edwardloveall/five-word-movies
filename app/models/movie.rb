class Movie < ActiveRecord::Base
  attr_accessible :five_words, :title

  def next_movie
    self.class.where('id > ?', self.id).order('id').first
  end
end
