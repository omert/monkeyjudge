class AddSlugToMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :slug, :string
  end

  def self.down
    remove_column :movies, :slug
  end
end
