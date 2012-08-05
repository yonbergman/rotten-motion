class MovieController < UIViewController

  attr_accessor :movie

  def initWithMovie(movie)
    initWithNibName(nil, bundle: nil)
    @movie = movie
    self.title = movie.title
    self
  end

  def viewDidLoad
    super

    @info_container = UIView.alloc.initWithFrame [[0, 0], [self.view.frame.size.width, 200]]
    @info_container.backgroundColor = "FFF".to_color
    self.view.addSubview @info_container

    @name_label = UILabel.alloc.initWithFrame [[130, 30], [0, 0]]
    @name_label.text = movie.title
    @name_label.sizeToFit
    self.view.addSubview @name_label


    url = NSURL.URLWithString movie.poster
    data = NSData.dataWithContentsOfURL(url)
    poster = UIImage.alloc.initWithData data
    @poster = UIImageView.alloc.initWithImage(poster)
    self.view.addSubview @poster

  end

end