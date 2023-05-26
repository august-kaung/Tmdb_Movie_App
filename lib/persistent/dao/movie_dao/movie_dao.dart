import '../../../data/vos/movie_vo/movie_vo.dart';

abstract class MovieDAO {
  void save(List<MovieVO> movies);

  List<MovieVO>? getMovieListByGenreIDFromDataBase();

  List<MovieVO>? getTopRatedMoviesFromDataBase();

  List<MovieVO>? getPopularMoviesFromDataBase();

  List<MovieVO>? getSimilarMoviesFromDataBase();

  Stream<List<MovieVO>?> getMovieListByGenreIDFromDataBaseStream();

  Stream<List<MovieVO>?> getTopRatedMoviesFromDataBaseStream();

  Stream<List<MovieVO>?> getPopularMoviesFromDataBaseStream();

  Stream<List<MovieVO>?> getSimilarMoviesFromDataBaseStream();

  Stream watchMovieBox();

  void clearMoviesBox();

  void clearBoxByMoviesByGenresID();

  void clearSimilarMovies();
}
