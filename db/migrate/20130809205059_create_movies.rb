class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :five_words
      t.string :title

      t.timestamps
    end
  end
end
