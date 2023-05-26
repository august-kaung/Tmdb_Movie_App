import 'package:flutter/cupertino.dart';
import 'package:tmdb_app/data/vos/credit_vo/cast_vo/cast_vo.dart';
import 'package:tmdb_app/data/vos/credit_vo/cast_vo/crew_vo.dart';
import 'package:tmdb_app/data/vos/movie_vo/movie_vo.dart';
import 'package:tmdb_app/data/vos/movies_details_vo/movie_details_vo.dart';

import '../data/apply/tmdb_apply.dart';
import '../data/apply/tmdb_apply_impl.dart';

class MovieDetailsBloc extends ChangeNotifier {
  final TMDBApply _tmdbApply = TMDBApplyImpl();
  final ScrollController _scrollControllerForSimilarMovies = ScrollController();
  bool _dispose = false;
  MovieDetailsVO? _movieDetailsVO;
  List<CastVO>? _castList;
  List<CrewVO>? _crewList;
  List<MovieVO>? _similarMoviesList;
  int _pageCountForSimilarMovies = 1;

  MovieDetailsVO? get getMoviesDetailsVO => _movieDetailsVO;

  List<CastVO>? get getCastVO => _castList;

  List<CrewVO>? get getCrewVO => _crewList;

  List<MovieVO>? get getSimilarMovieList => _similarMoviesList;

  ScrollController get getScrollControllerForSimilarMovies =>
      _scrollControllerForSimilarMovies;

  MovieDetailsBloc(int movieID) {
    ///Clear Previous Similar movies
    _tmdbApply.clearSimilarMovies();

    ///Fetch Movie Details By ID From Network
    _tmdbApply.getMoviesDetailsFromNetwork(movieID);

    ///Fetch Actor By ID From Network
    _tmdbApply.getCastFromNetwork(movieID);

    ///Fetch Crew By ID From Network
    _tmdbApply.getCrewFromNetwork(movieID);

    ///Fetch Similar Movies From Network
    _tmdbApply.getSimilarMoviesFromNetwork(movieID, _pageCountForSimilarMovies);

    ///Listen Movie Details By ID From DataBase
    _tmdbApply.getMovieDetailsFromDataBase(movieID).listen((event) {
      if (event != null) {
        _movieDetailsVO = event;
      } else {
        _movieDetailsVO = null;
      }
      notifyListeners();
    });

    ///Listen Cast From DataBase
    _tmdbApply.getCastFromDataBase().listen((event) {
      if (event != null) {
        _castList = event;
      } else if (event == null) {
        _castList = null;
      } else {
        _castList = [];
      }
      notifyListeners();
    });

    ///Listen Crew From DataBase
    _tmdbApply.getCrewFromDataBase().listen((event) {
      if (event != null) {
        _crewList = event;
      } else if (event == null) {
        _crewList = null;
      } else {
        _crewList = [];
      }
      notifyListeners();
    });

    ///Listen Similar Movies From DataBase
    _tmdbApply.getSimilarMoviesFromDataBase().listen((event) {
      if (event != null) {
        _similarMoviesList = event;
      } else if (event == null) {
        _similarMoviesList = null;
      } else {
        _similarMoviesList = [];
      }
      notifyListeners();
    });

    ///Listen Scrolling for Similar Movies
    _scrollControllerForSimilarMovies.addListener(() {
      if (_scrollControllerForSimilarMovies.position.atEdge) {
        _pageCountForSimilarMovies++;
        final pixels = _scrollControllerForSimilarMovies.position.pixels;
        if (pixels != 0) {
          _tmdbApply.getSimilarMoviesFromNetwork(
              movieID, _pageCountForSimilarMovies);
        }
      }
    });
  }

  @override
  void notifyListeners() {
    if (!_dispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
    _scrollControllerForSimilarMovies.dispose();
  }
}
