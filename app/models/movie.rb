class Movie < ActiveRecord::Base
  def self.add(code)
    # TODO make sure the imdb code is valid
    imdb_url = "http://www.imdb.com/title/tt#{code}/"
    imdb_page = open(imdb_url).read 
    imdb_parsed = Nokogiri::HTML.parse(imdb_page)
    title = imdb_parsed.css('#tn15title h1').text.to_s[/.+\)/]
    year = title.slice!(/\(\d{4}\)/).delete("()")
    score = imdb_parsed.css('#tn15rating .meta b').text
    create({
      :name => title, :imdb_id => code,
      :imdb_score => score, :year => year
    })
  end
end
