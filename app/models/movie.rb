class Movie < ActiveRecord::Base
  validates_uniqueness_of :slug

  before_create :create_slug

  def self.add(code)
    # TODO make sure the imdb code is valid
  end



  def self.scrape_imdb(code)
    imdb_url = "http://www.imdb.com/title/tt#{code}/"
    imdb_page = open(imdb_url).read 
    imdb_parsed = Nokogiri::HTML.parse(imdb_page)
    title = imdb_parsed.css('#tn15title h1').text.to_s[/.+\)/]
    year = title.slice!(/\(\d{4}\)/).delete("()")
    score = imdb_parsed.css('#tn15rating .meta b').text
    poster = imdb_parsed.css("div .photo")[0].css("a img")[0].attribute("src").to_s
    i = poster.index("._SX")
    poster = poster.slice(0..i)
    movie = Movie.find_by_imdb_iden(code) || Movie.new
    movie.name = title
    movie.imdb_iden = code
    movie.imdb_score = score
    movie.year = year
    movie.poster = poster
    movie.save
    return movie
  end

  def self.search_imdb(title)
    page = open("http://www.imdb.com/find?s=tt&q=" + CGI.escape(title)).read
    doc = Nokogiri::HTML.parse(page)
    imdb_iden = doc.css("table")[0].css("a")[0].attribute("href").to_s[/\d+/]
  end

  def to_param
    slug
  end

  private

  def create_slug
    self.slug = self.name.parameterize
    if !valid? && errors["slug"]
      self.slug = if year
        self.slug + "-#{year}"
      else
        self.slug + "-2"
      end
    end
  end
end
