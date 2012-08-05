class MovieListController < UIViewController

  attr_accessor :movies

  def initWithNibName(name, bundle: bundle)
    super
    self.title = "In Theaters Now"
    @movies = Movies.new()
    App.notification_center.observe "MoviesLoaded" do |notification|
      update_table
    end

    self
  end

  def viewDidLoad
    super
    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    @table.dataSource = @movies
    @table.delegate = self
    self.view.addSubview @table
  end

  def update_table
    @table.reloadData()
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
     tableView.deselectRowAtIndexPath(indexPath, animated: true)

     #App.alert("Selected #{movie_for_row(indexPath.row)}")
     movie_controller = MovieController.alloc.initWithMovie(movies.movie_for_row(indexPath.row))
     self.navigationController.pushViewController(movie_controller, animated: true)
  end

end