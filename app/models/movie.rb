class Movie

  attr_accessor :title, :year, :rating
  attr_accessor :synopsis, :poster, :review

  attr_reader :poster_data

  def initialize(hash = {})
    @title = hash[:title]
    @year = hash[:year]
    @rating = hash[:ratings][:critics_rating]
    @synopsis = hash[:synopsis]
    @poster = hash[:posters][:profile]
    @review = hash[:critics_consensus]
    url = NSURL.URLWithString hash[:posters][:thumbnail]
    @poster_data = NSData.dataWithContentsOfURL(url)
  end


end