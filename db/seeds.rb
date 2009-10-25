# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

require 'cgi'
require 'open-uri'
require 'nokogiri'

if Movie.count == 0
  imdb_url = 'http://www.imdb.com/chart/top'
  imdb_page = open(imdb_url).read 
  imdb_parsed = Nokogiri::HTML.parse(imdb_page)
  imdb_parsed.css('#main table tr').each_with_index do |row, i|
    if i > 0
      link = row.css('a')[0]
      imdb_id = link.attribute('href').to_s[/\d+/]
      imdb_score = imdb_parsed.css("#main table tr")[2].css("font")[1].content
      year = imdb_parsed.css("#main table tr")[2].css("font")[2].content[/\(\d+\)$/].delete("()")
      Movie.create :name => link.content, :imdb_id => imdb_id, :imdb_score => imdb_score, :year => year
      
    end
  end
end
