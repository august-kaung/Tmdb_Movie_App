import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/bloc/home_page_bloc.dart';
import 'package:tmdb_app/bloc/search_page_bloc.dart';

extension BlocInstance on BuildContext {
  HomePageBloc getHomePageBlocInstance() => read<HomePageBloc>();

  SearchPageBloc getSearchPageBlocInstance() => read<SearchPageBloc>();

  Future navigateToNextScreen(BuildContext context, Widget nextScreen) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => nextScreen));

  Future navigateToNextScreenReplacement(
          BuildContext context, Widget nextScreen) =>
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => nextScreen));

  void navigateBack(BuildContext context) => Navigator.of(context).pop();
}

extension StringExtensions on String {
  String addS() {
    if (length <= 1) {
      return this;
    }
    return '${this}s';
  }
}
