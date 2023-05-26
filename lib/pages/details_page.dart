import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/bloc/movie_details_bloc.dart';
import 'package:tmdb_app/constant/colors.dart';
import 'package:tmdb_app/constant/dimens.dart';
import 'package:tmdb_app/data/vos/movies_details_vo/movie_details_vo.dart';
import 'package:tmdb_app/utils/extensions_utils.dart';
import 'package:tmdb_app/widgets/loading_widget.dart';
import '../view_items/movie_details_view_items/movie_details_view_items.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.movieID}) : super(key: key);
  final int movieID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieDetailsBloc(movieID),
      child: Scaffold(
        backgroundColor: kPrimaryBackgroundColor,
        body: Selector<MovieDetailsBloc, MovieDetailsVO?>(
          selector: (_, bloc) => bloc.getMoviesDetailsVO,
          builder: (_, movieDetails, __) => movieDetails == null
              ? const LoadingWidget()
              : NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    DetailsMovieImageGenresItemView(
                        movieName: movieDetails.originalTitle ?? '',
                        movieImage: movieDetails.backdropPath ?? '',
                        onTapBack: () {
                          context.navigateBack(context);
                        },
                        movieGenresAndRunTimList:
                            movieDetails.getMovieGenresAndRunTime())
                  ],
                  body: ListView(
                    padding: const EdgeInsets.all(0),
                    children: [
                      const SizedBox(
                        height: kSP10x,
                      ),

                      ///Story Line Session
                      StoryLineItemView(
                        overview: movieDetails.overview ?? '',
                      ),
                      const SizedBox(
                        height: kSP10x,
                      ),

                      ///Cast Session
                      const StartCastItemView(),
                      const SizedBox(
                        height: kSP20x,
                      ),

                      ///Crew Session
                      const TalentSquadItemView(),
                      const SizedBox(
                        height: kSP20x,
                      ),

                      ///Production Company  Session
                      ProductionCompaniesItemView(
                          productionCompaniesVO:
                              movieDetails.productionCompanies ?? []),
                      const SizedBox(
                        height: kSP20x,
                      ),

                      ///Recommended Movie  Session
                      const RecommendedMovieItemView(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
