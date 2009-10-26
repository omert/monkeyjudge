class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string  :name
      t.integer :year
      t.string  :imdb_iden
      t.float   :imdb_score
      t.float   :rt_score
      t.float   :mc_score
      t.timestamps
    end
  end

  def self.down
    drop_table :movies
  end
end
