class Movie < ActiveRecord::Base
  validates_uniqueness_of :slug

  before_create :create_slug

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

  def self.search_imdb(title)

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
