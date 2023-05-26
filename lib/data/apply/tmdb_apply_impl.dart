import 'package:stream_transform/stream_transform.dart';
import 'package:tmdb_app/data/apply/tmdb_apply.dart';
import 'package:tmdb_app/data/vos/actor_details_vo/actor_details_vo.dart';
import 'package:tmdb_app/data/vos/actor_vo/actor_vo.dart';
import 'package:tmdb_app/data/vos/credit_vo/cast_vo/cast_vo.dart';
import 'package:tmdb_app/data/vos/credit_vo/cast_vo/crew_vo.dart';
import 'package:tmdb_app/data/vos/genre_vo/genre_vo.dart';
import 'package:tmdb_app/data/vos/movie_vo/movie_vo.dart';
import 'package:tmdb_app/data/vos/movies_details_vo/movie_details_vo.dart';
import 'package:tmdb_app/network/data_agent/tmdb_data_agent.dart';
import 'package:tmdb_app/network/data_agent/tmdb_data_agent_impl.dart';
import 'package:tmdb_app/persistent/dao/actor_dao/actor_dao.dart';
import 'package:tmdb_app/persistent/dao/actor_dao/actor_dao_impl.dart';
import 'package:tmdb_app/persistent/dao/actor_details_dao/actor_details_dao.dart';
import 'package:tmdb_app/persistent/dao/actor_details_dao/actor_details_dao_impl.dart';
import 'package:tmdb_app/persistent/dao/cast_dao/cast_dao.dart';
import 'package:tmdb_app/persistent/dao/cast_dao/cast_dao_impl.dart';
import 'package:tmdb_app/persistent/dao/crew_dao/crew_dao.dart';
import 'package:tmdb_app/persistent/dao/crew_dao/crew_dao_impl.dart';
import 'package:tmdb_app/persistent/dao/genre_dao/genre_dao.dart';
import 'package:tmdb_app/persistent/dao/genre_dao/genre_dao_impl.dart';
import 'package:tmdb_app/persistent/dao/movie_dao/movie_dao.dart';
import 'package:tmdb_app/persistent/dao/movie_dao/movie_dao_impl.dart';
import 'package:tmdb_app/persistent/dao/movie_details_dao/movie_details_dao.dart';
import 'package:tmdb_app/persistent/dao/movie_details_dao/movie_details_dao_impl.dart';
import 'package:tmdb_app/persistent/dao/search_history_dao/search_history_dao.dart';
import 'package:tmdb_app/persistent/dao/search_history_dao/search_history_dao_impl.dart';

class TMDBApplyImpl extends TMDBApply {
  TMDBApplyImpl._();

  static final TMDBApplyImpl _singleton = TMDBApplyImpl._();

  factory TMDBApplyImpl() => _singleton;

  final TMDBDataAgent _tmdbDataAgent = TMDBDataAgentImpl();
  final MovieDAO _movieDAO = MovieDAOImpl();
  final GenreDAO _genreDAO = GenreDAOImpl();
  final ActorDAO _actorDAO = ActorDAOImpl();
  final ActorDetailsDAO _actorDetailsDAO = ActorDetailsDAOImpl();
  final SearchHistoryDAO _searchHistoryDAO = SearchHistoryDAOImpl();
  final MovieDetailsDAO _movieDetailsDAO = MovieDetailsDAOImpl();
  final CastDAO _castDAO = CastDAOImpl();
  final CrewDAO _crewDAO = CrewDAOImpl();

  @override
  Future<List<GenreVO>?> getGenresListFromNetwork() =>
      _tmdbDataAgent.getGenresList().then((value) {
        if (value != null) {
          _genreDAO.save(value);
          getMovieListByGenresIDFromNetwork(value.first.id ?? 0, 1);
        }
        return value;
      });

  @override
  Future<List<MovieVO>?> getMovieListByGenresIDFromNetwork(
          int genreID, int page,
          {bool isDeleteAll = false}) =>
      _tmdbDataAgent.getMovieListByGenresID(genreID, page).then((value) {
        if (value != null) {
          var temp = value;
          temp = temp.map((e) {
            e.isMoviesByGenres = true;
            return e;
          }).toList();

          _movieDAO.save(temp);
        }
        return value;
      });

  @override
  Stream<List<GenreVO>?> getGenresListFromNetworkFromDataBase() {
    return _genreDAO
        .watchGenreBox()
        .startWith(_genreDAO.getGenreListFromDataBaseStream())
        .map((event) => _genreDAO.getGenreListFromDataBase());
  }

  @override
  Stream<List<MovieVO>?> getMovieListByGenresIDFromDataBase() {
    return _movieDAO
        .watchMovieBox()
        .startWith(_movieDAO.getMovieListByGenreIDFromDataBaseStream())
        .map((event) => _movieDAO.getMovieListByGenreIDFromDataBase());
  }

  @override
  void clearMoviesBox() {
    _movieDAO.clearMoviesBox();
  }

  @override
  Future<List<MovieVO>?> getTopRatedMoviesFromNetwork(int page) =>
      _tmdbDataAgent.getTopRatedMovies(page).then((value) {
        if (value != null) {
          var temp = value;
          temp = temp.map((e) {
            e.isGetNowPlaying = true;
            return e;
          }).toList();

          _movieDAO.save(temp);
        }
        return value;
      });

  @override
  Future<List<MovieVO>?> getPopularMoviesFromNetwork(int page) =>
      _tmdbDataAgent.getPopularMovies(page).then((value) {
        if (value != null) {
          var temp = value;
          temp = temp.map((e) {
            e.isPopularMovies = true;
            return e;
          }).toList();

          _movieDAO.save(temp);
        }
        return value;
      });

  @override
  Stream<List<MovieVO>?> getTopRatedMoviesFromDataBase() => _movieDAO
      .watchMovieBox()
      .startWith(_movieDAO.getTopRatedMoviesFromDataBaseStream())
      .map((event) => _movieDAO.getTopRatedMoviesFromDataBase());

  @override
  Stream<List<MovieVO>?> getPopularMoviesFromDataBase() => _movieDAO
      .watchMovieBox()
      .startWith(_movieDAO.getPopularMoviesFromDataBaseStream())
      .map((event) => _movieDAO.getPopularMoviesFromDataBase());

  @override
  void clearBoxByMoviesByGenresID() {
    _movieDAO.clearBoxByMoviesByGenresID();
  }

  @override
  Stream<List<ActorVO>?> getActorFromDataBase() => _actorDAO
      .watchActorBox()
      .startWith(_actorDAO.getActorListFromDataBaseStream())
      .map((event) => _actorDAO.getActorFromDataBase());

  @override
  Future<List<ActorVO>?> getActorFromNetwork(int page) =>
      _tmdbDataAgent.getActors(page).then((value) {
        if (value != null) {
          _actorDAO.save(value);
        }
        return value;
      });

  @override
  void clearActorBox() {
    _actorDAO.clearActorBox();
  }

  @override
  void clearGenreBox() {
    _genreDAO.clearGenreBox();
  }

  @override
  Stream<ActorDetailsVO?> getActorDetailsFromDataBase(int actorID) =>
      _actorDetailsDAO
          .watchActorDetailsBox()
          .startWith(
              _actorDetailsDAO.getActorDetailsListFromDataBaseStream(actorID))
          .map((event) =>
              _actorDetailsDAO.getActorDetailsListFromDataBase(actorID));

  @override
  Future<ActorDetailsVO?> getActorDetailsFromNetwork(int actorID) =>
      _tmdbDataAgent.getActorsDetails(actorID).then((value) {
        if (value != null) {
          _actorDetailsDAO.save(value);
        }
        return value;
      });

  @override
  Future<List<MovieVO>?> getSearchMoviesFromNetwork(int page, String query) =>
      _tmdbDataAgent.getSearchMovies(page, query);

  @override
  List<String>? getSearchHistoryList() => _searchHistoryDAO.getSearchHistory();

  @override
  void saveSearchHistory(String query) => _searchHistoryDAO.save(query);

  @override
  String getGenresListByID(List<int> genresID) =>
      _genreDAO.getGenresListByID(genresID);

  @override
  Stream<MovieDetailsVO?> getMovieDetailsFromDataBase(int movieID) =>
      _movieDetailsDAO
          .watchMovieDetailsBox()
          .startWith(_movieDetailsDAO.getMoviesDetailsMovieIDStream(movieID))
          .map((event) => _movieDetailsDAO.getMoviesDetailsByMovieID(movieID));

  @override
  Future<MovieDetailsVO?> getMoviesDetailsFromNetwork(int movieID) =>
      _tmdbDataAgent.getMovieDetails(movieID).then((value) {
        if (value != null) {
          _movieDetailsDAO.save(value);
        }
        return value;
      });

  @override
  Stream<List<CastVO>?> getCastFromDataBase() => _castDAO
      .watchCastBox()
      .startWith(_castDAO.getCastListStream())
      .map((event) => _castDAO.getCastList());

  @override
  Future<List<CastVO>?> getCastFromNetwork(int movieID) =>
      _tmdbDataAgent.getCast(movieID).then((value) {
        if (value != null) {
          _castDAO.save(value);
        }
        return value;
      });

  @override
  Stream<List<CrewVO>?> getCrewFromDataBase() => _crewDAO
      .watchCrewBox()
      .startWith(_crewDAO.getCrewListStream())
      .map((event) => _crewDAO.getCrewList());

  @override
  Future<List<CrewVO>?> getCrewFromNetwork(int movieID) =>
      _tmdbDataAgent.getCrew(movieID).then((value) {
        if (value != null) {
          _crewDAO.save(value);
        }
        return value;
      });

  @override
  Stream<List<MovieVO>?> getSimilarMoviesFromDataBase() => _movieDAO
      .watchMovieBox()
      .startWith(_movieDAO.getSimilarMoviesFromDataBaseStream())
      .map((event) => _movieDAO.getSimilarMoviesFromDataBase());

  @override
  Future<List<MovieVO>?> getSimilarMoviesFromNetwork(int movieID, int page) =>
      _tmdbDataAgent.getSimilarMovies(page, movieID).then((value) {
        if (value != null) {
          var temp = value;
          temp = temp.map((e) {
            e.isSimilarMovies = true;
            return e;
          }).toList();
          _movieDAO.save(temp);
        }
        return value;
      });

  @override
  void clearSimilarMovies() {
    _movieDAO.clearSimilarMovies();
  }
}
