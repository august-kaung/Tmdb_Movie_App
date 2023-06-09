import 'package:hive/hive.dart';
import 'package:tmdb_app/constant/hive_constant.dart';
import 'package:tmdb_app/data/vos/movies_details_vo/movie_details_vo.dart';
import 'package:tmdb_app/persistent/dao/movie_details_dao/movie_details_dao.dart';

class MovieDetailsDAOImpl extends MovieDetailsDAO {
  MovieDetailsDAOImpl._();

  static final MovieDetailsDAOImpl _singleton = MovieDetailsDAOImpl._();

  factory MovieDetailsDAOImpl() => _singleton;

  @override
  MovieDetailsVO? getMoviesDetailsByMovieID(int movieID) =>
      _getMovieDetailsBox().get(movieID);

  @override
  Stream<MovieDetailsVO?> getMoviesDetailsMovieIDStream(int movieID) =>
      Stream.value(getMoviesDetailsByMovieID(movieID));

  @override
  void save(MovieDetailsVO movieDetailsVO) {
    _getMovieDetailsBox().put(movieDetailsVO.id, movieDetailsVO);
  }

  @override
  Stream watchMovieDetailsBox() => _getMovieDetailsBox().watch();

  Box<MovieDetailsVO> _getMovieDetailsBox() =>
      Hive.box<MovieDetailsVO>(kBoxNameForMovieDetailsVO);
}
