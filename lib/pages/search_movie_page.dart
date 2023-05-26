import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/bloc/search_page_bloc.dart';
import 'package:tmdb_app/constant/colors.dart';
import 'package:tmdb_app/constant/dimens.dart';
import '../view_items/search_page_view_items/search_view_items.dart';

class SearchMoviePage extends StatelessWidget {
  const SearchMoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchPageBloc>(
      create: (_) => SearchPageBloc(),
      child: Scaffold(
        backgroundColor: kPrimaryBackgroundColor,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),

            ///Back Button Session
            const BackButtonItemView(),
            const SizedBox(
              height: kSP20x,
            ),

            ///Search TextField  Session
            const SearchTextFieldView(),
            const SizedBox(
              height: kSP5x,
            ),

            ///Show Result Movie List Session
            const SearchListItemView(),
          ],
        ),
      ),
    );
  }
}
