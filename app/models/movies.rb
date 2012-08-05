class Movies
  IN_THEATERS = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=xhz93x4s7b6j8ufefxh9uj2w"

  def initialize
    @data = []
    load()
    self
  end

  def load()
    BW::HTTP.get(IN_THEATERS) do |response|
      result_data = BW::JSON.parse(response.body.to_str)
      movies_hashes = result_data["movies"]
      movies = movies_hashes.map do |movie_hash|
        Movie.new(movie_hash)
      end
      @data = movies
      App.notification_center.post "MoviesLoaded"
    end
  end

  def movie_for_row(row)
    @data[row]
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
     UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    cell.textLabel.text = movie_for_row(indexPath.row).title
    cell.imageView.initWithImage(UIImage.alloc.initWithData(movie_for_row(indexPath.row).poster_data))

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @data.count
  end



end