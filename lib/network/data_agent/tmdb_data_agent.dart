import 'package:tmdb_app/data/vos/actor_details_vo/actor_details_vo.dart';
import 'package:tmdb_app/data/vos/actor_vo/actor_vo.dart';
import 'package:tmdb_app/data/vos/credit_vo/cast_vo/cast_vo.dart';
import 'package:tmdb_app/data/vos/credit_vo/cast_vo/crew_vo.dart';
import 'package:tmdb_app/data/vos/genre_vo/genre_vo.dart';

import '../../data/vos/movie_vo/movie_vo.dart';
import '../../data/vos/movies_details_vo/movie_details_vo.dart';

abstract class TMDBDataAgent {
  Future<List<MovieVO>?> getMovieListByGenresID(int genreID, int page);

  Future<List<GenreVO>?> getGenresList();

  Future<List<MovieVO>?> getTopRatedMovies(int page);

  Future<List<MovieVO>?> getPopularMovies(int page);

  Future<List<ActorVO>?> getActors(int page);

  Future<ActorDetailsVO?> getActorsDetails(int actorID);

  Future<List<MovieVO>?> getSearchMovies(int page, String query);

  Future<MovieDetailsVO?> getMovieDetails(int movieID);

  Future<List<CastVO>?> getCast(int movieID);

  Future<List<CrewVO>?> getCrew(int movieID);

  Future<List<MovieVO>?> getSimilarMovies(int page, int movieID);
}
