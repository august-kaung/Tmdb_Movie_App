import 'package:flutter/cupertino.dart';
import 'package:tmdb_app/data/apply/tmdb_apply.dart';
import 'package:tmdb_app/data/apply/tmdb_apply_impl.dart';
import 'package:tmdb_app/data/vos/actor_vo/actor_vo.dart';
import 'package:tmdb_app/data/vos/genre_vo/genre_vo.dart';
import 'package:tmdb_app/data/vos/movie_vo/movie_vo.dart';

class HomePageBloc extends ChangeNotifier {
  final TMDBApply _tmdbApply = TMDBApplyImpl();
  final ScrollController _scrollControllerForMovieByGenres = ScrollController();
  final ScrollController _scrollControllerForGetNowPlayingMovies =
      ScrollController();
  final ScrollController _scrollControllerForPopularMovies = ScrollController();

  bool _dispose = false;
  List<GenreVO>? _genreList = [];
  List<MovieVO>? _bannerMovieList = [];
  List<MovieVO>? _genreMovieList = [];
  List<MovieVO>? _getNowPlayingMovies = [];
  List<MovieVO>? _getPopularMovies = [];
  List<ActorVO>? _getActors = [];

  bool get isDispose => _dispose;

  List<GenreVO>? get getGenreList => _genreList;

  List<MovieVO>? get getBannerMovieList => _bannerMovieList;

  List<MovieVO>? get getGenreMovieList => _genreMovieList;

  List<MovieVO>? get getNowPlayingMovieList => _getNowPlayingMovies;

  List<MovieVO>? get getPopularMoviesList => _getPopularMovies;

  List<ActorVO>? get getActorList => _getActors;

  ScrollController get getScrollControllerForMovieByGenres =>
      _scrollControllerForMovieByGenres;

  ScrollController get getScrollControllerForGetNowPLayingMovies =>
      _scrollControllerForGetNowPlayingMovies;

  ScrollController get getScrollControllerForPopularMovies =>
      _scrollControllerForPopularMovies;

  int _pageCountForMovieByGenres = 1;
  int _pageCountForGetNowPlayingMovies = 1;
  int _pageCountForPopularMovies = 1;
  int _pageCountForActors = 1;
  int genreID = 0;

  HomePageBloc() {
    ///Always Clear Data in Database
    _tmdbApply.clearMoviesBox();
    _tmdbApply.clearActorBox();
    _tmdbApply.clearGenreBox();

    ///Fetch Data Genre List and Call Movie by Genres ID (Inside Method)
    _tmdbApply.getGenresListFromNetwork();

    ///Fetch Get Now Playing Movie List
    _tmdbApply.getTopRatedMoviesFromNetwork(_pageCountForGetNowPlayingMovies);

    ///Fetch Popular Movie List
    _tmdbApply.getPopularMoviesFromNetwork(_pageCountForPopularMovies);

    ///Fetch Actor Movie List
    _tmdbApply.getActorFromNetwork(_pageCountForActors);

    ///Listen Genre List From DataBase
    _tmdbApply.getGenresListFromNetworkFromDataBase().listen((event) {
      if (event != null && event.isNotEmpty) {
        _genreList = event;
        genreID = _genreList?.first.id ?? 0;
      } else if (event == null) {
        _genreList = null;
      } else {
        _genreList = [];
      }
      notifyListeners();
    });

    ///Listen Movies By Genres ID From DataBase
    _tmdbApply.getMovieListByGenresIDFromDataBase().listen((event) {
      if (event != null && event.isNotEmpty) {
        _bannerMovieList = event.take(5).toList();
        _genreMovieList = event;
      } else if (event == null) {
        _bannerMovieList = null;
        _genreMovieList = null;
      } else {
        _bannerMovieList = [];
        _genreMovieList = [];
      }
      notifyListeners();
    });

    ///Listen Top Rated Movies From DataBase
    _tmdbApply.getTopRatedMoviesFromDataBase().listen((event) {
      if (event != null && event.isNotEmpty) {
        _getNowPlayingMovies = event;
      } else if (event == null) {
        _getNowPlayingMovies = null;
      } else {
        _getNowPlayingMovies = [];
      }
      notifyListeners();
    });

    ///Listen Popular Movies From DataBase
    _tmdbApply.getPopularMoviesFromDataBase().listen((event) {
      if (event != null && event.isNotEmpty) {
        _getPopularMovies = event;
      } else if (event == null) {
        _getPopularMovies = null;
      } else {
        _getPopularMovies = [];
      }
      notifyListeners();
    });

    _tmdbApply.getActorFromDataBase().listen((event) {
      if (event != null && event.isNotEmpty) {
        _getActors = event;
      } else if (event == null) {
        _getActors = null;
      } else {
        _getActors = [];
      }
      notifyListeners();
    });

    ///Listen Movies By Genres Session of Scrolling
    _scrollControllerForMovieByGenres.addListener(() {
      if (_scrollControllerForMovieByGenres.position.atEdge) {
        _pageCountForMovieByGenres++;
        final pixels = _scrollControllerForMovieByGenres.position.pixels;
        if (pixels != 0) {
          _tmdbApply.getMovieListByGenresIDFromNetwork(
              genreID, _pageCountForMovieByGenres);
        }
      }
    });

    ///Listen Get now playing Movies Session of Scrolling
    _scrollControllerForGetNowPlayingMovies.addListener(() {
      if (_scrollControllerForGetNowPlayingMovies.position.atEdge) {
        _pageCountForGetNowPlayingMovies++;
        final pixels = _scrollControllerForGetNowPlayingMovies.position.pixels;
        if (pixels != 0) {
          _tmdbApply
              .getTopRatedMoviesFromNetwork(_pageCountForGetNowPlayingMovies);
        }
      }
    });

    ///Listen Popular Movies Session of Scrolling
    _scrollControllerForPopularMovies.addListener(() {
      if (_scrollControllerForPopularMovies.position.atEdge) {
        _pageCountForPopularMovies++;
        final pixels = _scrollControllerForPopularMovies.position.pixels;
        if (pixels != 0) {
          _tmdbApply.getPopularMoviesFromNetwork(_pageCountForPopularMovies);
        }
      }
    });
  }

  void fetchMoreActor(int index) {
    if (index != 0 && index % 10 == 0) {
      _pageCountForActors++;
      _tmdbApply.getActorFromNetwork(_pageCountForActors);
    }
  }

  void setGenreTypeSelect(int id) {
    _tmdbApply.clearBoxByMoviesByGenresID();
    genreID = id;
    _genreList = _genreList?.map((e) {
      if (e.id == id) {
        e.isSelect = true;
      } else {
        e.isSelect = false;
      }
      return e;
    }).toList();
    _genreList = _genreList?.map((e) => e).toList();
    _pageCountForMovieByGenres = 1;
    _tmdbApply.getMovieListByGenresIDFromNetwork(
        id, _pageCountForMovieByGenres);
    notifyListeners();
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
    _scrollControllerForMovieByGenres.dispose();
    _scrollControllerForGetNowPlayingMovies.dispose();
    _scrollControllerForPopularMovies.dispose();
  }
}
