import 'package:flutter/material.dart';
import 'package:tmdb_app/data/vos/movie_vo/movie_vo.dart';

import '../data/apply/tmdb_apply.dart';
import '../data/apply/tmdb_apply_impl.dart';

class SearchPageBloc extends ChangeNotifier {
  final TMDBApply _tmdbApply = TMDBApplyImpl();
  final ScrollController _scrollControllerForSearchMovieList =
      ScrollController();

  List<MovieVO>? _searchMovieList;
  List<String>? _searchHistoryList;
  bool _dispose = false;
  bool _searching = false;
  String _query = '';

  List<MovieVO>? get getSearchMovieList => _searchMovieList;

  List<String>? get getSearchHistoryList => _searchHistoryList;

  ScrollController get getScrollControllerForSearchHistory =>
      _scrollControllerForSearchMovieList;

  bool get isSearching => _searching;
  int _pageCountForSearchMovies = 1;
  SearchPageBloc() {
    ///Get Search History From Database
    final list = _tmdbApply.getSearchHistoryList();
    if (list == null) {
      _searchHistoryList = null;
    } else if (list.isEmpty) {
      _searchHistoryList = [];
    } else {
      _searchHistoryList = list;
    }
    notifyListeners();

    ///Listening Scroll on Search Movie List
    _scrollControllerForSearchMovieList.addListener(() {
      if (_scrollControllerForSearchMovieList.position.atEdge) {
        _pageCountForSearchMovies++;
        final pixels = _scrollControllerForSearchMovieList.position.pixels;
        if (pixels != 0) {
          _tmdbApply
              .getSearchMoviesFromNetwork(_pageCountForSearchMovies, _query)
              .then((value) {
            if (value != null) {
              for (var element in value) {
                _searchMovieList?.add(element);
              }
              _searchMovieList = _searchMovieList?.map((e) => e).toList();
              notifyListeners();
            }
          });
        }
      }
    });
  }

  void search(String query) {
    _query = query;
    _searching = true;
    notifyListeners();
    _tmdbApply
        .getSearchMoviesFromNetwork(_pageCountForSearchMovies, query)
        .then((value) {
      if (value != null) {
        _searchMovieList = value;
        notifyListeners();
      }
    }).whenComplete(() {
      _searching = false;
      notifyListeners();
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
    _scrollControllerForSearchMovieList.dispose();
  }
}
