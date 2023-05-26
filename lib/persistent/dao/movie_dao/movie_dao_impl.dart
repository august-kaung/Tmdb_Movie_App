import 'package:hive/hive.dart';
import 'package:tmdb_app/constant/hive_constant.dart';
import 'package:tmdb_app/data/vos/movie_vo/movie_vo.dart';
import 'package:tmdb_app/persistent/dao/movie_dao/movie_dao.dart';

class MovieDAOImpl extends MovieDAO {
  MovieDAOImpl._();

  static final MovieDAOImpl _singleton = MovieDAOImpl._();

  factory MovieDAOImpl() => _singleton;

  @override
  List<MovieVO>? getMovieListByGenreIDFromDataBase() {
    List<MovieVO> getMovies = _getMovieBox().values.toList();
    getMovies.sort((a, b) => a.order.compareTo(b.order));
    return getMovies
        .where((element) => element.isMoviesByGenres ?? false)
        .toList();
  }

  @override
  Stream<List<MovieVO>?> getMovieListByGenreIDFromDataBaseStream() =>
      Stream.value(getMovieListByGenreIDFromDataBase());

  @override
  void save(List<MovieVO> movies) {
    int order = 0;
    final temp = getMovieListByGenreIDFromDataBase();
    if (temp != null && temp.isNotEmpty) {
      order = temp.last.order;
    }
    for (MovieVO movie in movies) {
      order++;
      movie.order = order;
      _getMovieBox().put(movie.id, movie);
    }
  }

  @override
  Stream watchMovieBox() => _getMovieBox().watch();

  Box<MovieVO> _getMovieBox() => Hive.box<MovieVO>(kBoxNameForMovieVO);

  @override
  void clearMoviesBox() => _getMovieBox().clear();

  @override
  List<MovieVO>? getTopRatedMoviesFromDataBase() {
    final getMovies = _getMovieBox().values.toList();
    getMovies.sort((a, b) => a.order.compareTo(b.order));
    return getMovies
        .where((element) => element.isGetNowPlaying ?? false)
        .toList();
  }

  @override
  Stream<List<MovieVO>?> getTopRatedMoviesFromDataBaseStream() =>
      Stream.value(getTopRatedMoviesFromDataBase());

  @override
  List<MovieVO>? getPopularMoviesFromDataBase() {
    final getMovies = _getMovieBox().values.toList();
    getMovies.sort((a, b) => a.order.compareTo(b.order));
    return getMovies
        .where((element) => element.isPopularMovies ?? false)
        .toList();
  }

  @override
  Stream<List<MovieVO>?> getPopularMoviesFromDataBaseStream() =>
      Stream.value(getPopularMoviesFromDataBase());

  @override
  void clearBoxByMoviesByGenresID() {
    final getMovies = _getMovieBox().values.toList();
    final listID = getMovies
        .where((element) => element.isMoviesByGenres ?? false)
        .map((e) => e.id)
        .toList();
    for (int? id in listID) {
      _getMovieBox().delete(id);
    }
  }

  @override
  List<MovieVO>? getSimilarMoviesFromDataBase() {
    List<MovieVO> similarMovies = _getMovieBox().values.toList();
    similarMovies.sort((a, b) => a.order.compareTo(b.order));
    return similarMovies
        .where((element) => element.isSimilarMovies ?? false)
        .toList();
  }

  @override
  Stream<List<MovieVO>?> getSimilarMoviesFromDataBaseStream() =>
      Stream.value(getSimilarMoviesFromDataBase());

  @override
  void clearSimilarMovies() {
    final getMovies = _getMovieBox().values.toList();
    final listID = getMovies
        .where((element) => element.isSimilarMovies ?? false)
        .map((e) => e.id)
        .toList();
    for (int? id in listID) {
      _getMovieBox().delete(id);
    }
  }
}
