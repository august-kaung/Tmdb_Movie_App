import 'package:tmdb_app/data/vos/actor_details_vo/actor_details_vo.dart';
import 'package:tmdb_app/data/vos/actor_vo/actor_vo.dart';
import 'package:tmdb_app/data/vos/credit_vo/cast_vo/cast_vo.dart';
import 'package:tmdb_app/data/vos/credit_vo/cast_vo/crew_vo.dart';
import 'package:tmdb_app/data/vos/movies_details_vo/movie_details_vo.dart';

import '../vos/genre_vo/genre_vo.dart';
import '../vos/movie_vo/movie_vo.dart';

abstract class TMDBApply {
  ///Network
  Future<List<MovieVO>?> getMovieListByGenresIDFromNetwork(
    int genreID,
    int page,
  );

  Future<List<GenreVO>?> getGenresListFromNetwork();

  Future<List<MovieVO>?> getTopRatedMoviesFromNetwork(int page);

  Future<List<MovieVO>?> getPopularMoviesFromNetwork(int page);

  Future<List<ActorVO>?> getActorFromNetwork(int page);

  Future<ActorDetailsVO?> getActorDetailsFromNetwork(int actorID);

  Future<List<MovieVO>?> getSearchMoviesFromNetwork(int page, String query);

  Future<MovieDetailsVO?> getMoviesDetailsFromNetwork(int movieID);

  Future<List<CastVO>?> getCastFromNetwork(int movieID);

  Future<List<CrewVO>?> getCrewFromNetwork(int movieID);

  Future<List<MovieVO>?> getSimilarMoviesFromNetwork(int movieID, int page);

  ///Database
  Stream<List<MovieVO>?> getMovieListByGenresIDFromDataBase();

  Stream<List<GenreVO>?> getGenresListFromNetworkFromDataBase();

  Stream<List<MovieVO>?> getTopRatedMoviesFromDataBase();

  Stream<List<MovieVO>?> getPopularMoviesFromDataBase();

  Stream<List<ActorVO>?> getActorFromDataBase();

  Stream<ActorDetailsVO?> getActorDetailsFromDataBase(int actorID);

  Stream<MovieDetailsVO?> getMovieDetailsFromDataBase(int movieID);

  Stream<List<CastVO>?> getCastFromDataBase();

  Stream<List<CrewVO>?> getCrewFromDataBase();

  Stream<List<MovieVO>?> getSimilarMoviesFromDataBase();

  void saveSearchHistory(String query);

  List<String>? getSearchHistoryList();

  String getGenresListByID(List<int> genresID);

  //Clear Box
  void clearMoviesBox();

  void clearBoxByMoviesByGenresID();

  void clearActorBox();

  void clearGenreBox();

  void clearSimilarMovies();
}
