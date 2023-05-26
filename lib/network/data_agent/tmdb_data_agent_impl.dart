import 'package:dio/dio.dart';
import 'package:tmdb_app/constant/api_constant.dart';
import 'package:tmdb_app/data/vos/actor_details_vo/actor_details_vo.dart';
import 'package:tmdb_app/data/vos/actor_vo/actor_vo.dart';
import 'package:tmdb_app/data/vos/credit_vo/cast_vo/cast_vo.dart';
import 'package:tmdb_app/data/vos/credit_vo/cast_vo/crew_vo.dart';
import 'package:tmdb_app/data/vos/genre_vo/genre_vo.dart';
import 'package:tmdb_app/data/vos/movie_vo/movie_vo.dart';
import 'package:tmdb_app/data/vos/movies_details_vo/movie_details_vo.dart';
import 'package:tmdb_app/network/api/tmdb_api.dart';
import 'package:tmdb_app/network/data_agent/tmdb_data_agent.dart';

class TMDBDataAgentImpl extends TMDBDataAgent {
  late TMDBapi _tmdBapi;

  TMDBDataAgentImpl._() {
    _tmdBapi = TMDBapi(Dio());
  }

  static final TMDBDataAgentImpl _singleton = TMDBDataAgentImpl._();

  factory TMDBDataAgentImpl() => _singleton;

  @override
  Future<List<GenreVO>?> getGenresList() => _tmdBapi
      .getGenreResponse(kApiToken)
      .asStream()
      .map((event) => event.genres)
      .first;

  @override
  Future<List<MovieVO>?> getMovieListByGenresID(int genreID, int page) =>
      _tmdBapi
          .getMovieResponseByGenresIDResponse(genreID, kApiToken, page)
          .asStream()
          .map((event) => event.results)
          .first;

  @override
  Future<List<MovieVO>?> getTopRatedMovies(int page) => _tmdBapi
      .getTopRatedMoviesResponse(kApiToken, page)
      .asStream()
      .map((event) => event.results)
      .first;

  @override
  Future<List<MovieVO>?> getPopularMovies(int page) => _tmdBapi
      .getPopularMoviesResponse(kApiToken, page)
      .asStream()
      .map((event) => event.results)
      .first;

  @override
  Future<List<ActorVO>?> getActors(int page) => _tmdBapi
      .getActorsResponse(kApiToken, page)
      .asStream()
      .map((event) => event.results)
      .first;

  @override
  Future<ActorDetailsVO?> getActorsDetails(int actorID) =>
      _tmdBapi.getActorDetailsResponse(kApiToken, actorID);

  @override
  Future<List<MovieVO>?> getSearchMovies(int page, String query) => _tmdBapi
      .getSearchMovieResponse(kApiToken, query, page)
      .asStream()
      .map((event) => event.results)
      .first;

  @override
  Future<MovieDetailsVO?> getMovieDetails(int movieID) =>
      _tmdBapi.getMovieDetailsResponse(kApiToken, movieID);

  @override
  Future<List<CastVO>?> getCast(int movieID) => _tmdBapi
      .getCastAndCrewResponse(kApiToken, movieID)
      .asStream()
      .map((event) => event.cast)
      .first;

  @override
  Future<List<CrewVO>?> getCrew(int movieID) => _tmdBapi
      .getCastAndCrewResponse(kApiToken, movieID)
      .asStream()
      .map((event) => event.crew)
      .first;

  @override
  Future<List<MovieVO>?> getSimilarMovies(int page, int movieID) => _tmdBapi
      .getSimilarResponse(kApiToken, page, movieID)
      .asStream()
      .map((event) => event.results)
      .first;
}
