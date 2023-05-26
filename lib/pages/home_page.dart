import 'package:flutter/material.dart';
import 'package:tmdb_app/bloc/home_page_bloc.dart';
import 'package:tmdb_app/constant/colors.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/constant/dimens.dart';
import 'package:tmdb_app/pages/actor_details_page.dart';
import 'package:tmdb_app/pages/search_movie_page.dart';
import 'package:tmdb_app/utils/convert_movie_object_utils.dart';
import 'package:tmdb_app/utils/extensions_utils.dart';
import '../view_items/home_page_view_items/home_page_view_items.dart';
import '../widgets/search_movie_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>(
      create: (_) => HomePageBloc(),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(seconds: 1),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (_, opacity, child) => Opacity(
          opacity: opacity,
          child: child,
        ),
        child: Scaffold(
          backgroundColor: kPrimaryBackgroundColor,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),

                ///Search Movie Session
                SearchMovieWidget(
                  onTap: () {
                    context.navigateToNextScreen(
                        context, const SearchMoviePage());
                  },
                ),
                const SizedBox(
                  height: kSP10x,
                ),

                ////Genres List Session
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kSP10x, vertical: kSP10x),
                  height: kGenreListHeight,
                  child: const HorizontalGenreListItemView(),
                ),

                const SizedBox(
                  height: kSP10x,
                ),

                ///Banner Session
                const BannerMovieItemView(),

                const SizedBox(
                  height: kSP20x,
                ),

                ///Movie by Genres Session
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kSP10x, vertical: kSP10x),
                  height: kMovieByGenresHeight,
                  child: const MovieByGenreItemView(),
                ),
                const SizedBox(
                  height: kSP30x,
                ),

                ///You may like Session
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kSP10x, vertical: kSP10x),
                  height: kYouMayLikeAndPopularMoviesViewHeight,
                  child: const YouMayLikeItemView(),
                ),

                const SizedBox(
                  height: kSP30x,
                ),

                ///Popular movies Session
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kSP10x, vertical: kSP10x),
                  height: kYouMayLikeAndPopularMoviesViewHeight,
                  child: const PopularMoviesItemView(),
                ),

                const SizedBox(
                  height: kSP30x,
                ),

                ///Actors  Session
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kSP10x, vertical: kSP10x),
                  child: ActorListItemView(
                    onTapActor: (id, knowForList) {
                      context.navigateToNextScreen(
                          context,
                          ActorDetailsPage(
                            id: id,
                            movieList:
                                getMovieVOListFromKnowForVOList(knowForList),
                          ));
                    },
                  ),
                ),

                const SizedBox(
                  height: kSP30x,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
