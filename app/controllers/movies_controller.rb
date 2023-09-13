class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def create
    m = Movie.new

    m.title = params.fetch("query_title")
    m.year = params.fetch("query_year")
    m.duration = params.fetch("query_duration")
    m.description = params.fetch("query_description")
    m.image = params.fetch("query_image")
    m.director_id = params.fetch("query_director_id")

    m.save

    redirect_to "/movies"
  end

  def destroy
    the_id = params.fetch("path_id")
    matching_movie = Movie.where({ id: the_id }).first

    matching_movie.destroy

    redirect_to "/movies"
  end

  def update
    the_id = params.fetch("path_id")
    matching_movie = Movie.where({ id: the_id })[0]

    matching_movie.title = params.fetch("query_title")
    matching_movie.year = params.fetch("query_year")
    matching_movie.duration = params.fetch("query_duration")
    matching_movie.description = params.fetch("query_description")
    matching_movie.image = params.fetch("query_image")
    matching_movie.director_id = params.fetch("query_director_id")

    matching_movie.save

    redirect_to "/movies/#{matching_movie.id}"
  end
end
