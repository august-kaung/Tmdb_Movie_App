import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/bloc/movie_details_bloc.dart';
import 'package:tmdb_app/constant/colors.dart';
import 'package:tmdb_app/constant/dimens.dart';
import 'package:tmdb_app/data/vos/credit_vo/cast_vo/crew_vo.dart';
import 'package:tmdb_app/data/vos/movie_vo/movie_vo.dart';
import 'package:tmdb_app/data/vos/movies_details_vo/production_companies_vo.dart';
import 'package:tmdb_app/widgets/easy_text.dart';
import 'package:tmdb_app/widgets/loading_widget.dart';
import 'package:tmdb_app/widgets/movie_widget.dart';

import '../../constant/strings.dart';
import '../../data/vos/credit_vo/cast_vo/cast_vo.dart';
import '../../widgets/cache_network_image_widget.dart';
import '../../widgets/cast_and_crew_profile_name_widget.dart';

class RecommendedMovieItemView extends StatelessWidget {
  const RecommendedMovieItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<MovieDetailsBloc, List<MovieVO>?>(
        selector: (_, bloc) => bloc.getSimilarMovieList,
        builder: (_, moviesList, __) {
          if (moviesList == null) {
            return const LoadingWidget();
          }
          return RecommendedMovieView(
            movies: moviesList,
          );
        });
  }
}

class RecommendedMovieView extends StatelessWidget {
  const RecommendedMovieView({Key? key, required this.movies})
      : super(key: key);
  final List<MovieVO> movies;

  @override
  Widget build(BuildContext context) {
    return Selector<MovieDetailsBloc, ScrollController>(
        selector: (_, bloc) => bloc.getScrollControllerForSimilarMovies,
        builder: (_, controller, __) => Padding(
              padding: const EdgeInsets.all(kSP10x),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const EasyText(
                    text: kRecommendedText,
                    fontSize: kFontSie23x,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: kSP15x,
                  ),
                  SizedBox(
                    height: kYouMayLikeAndPopularMoviesViewHeight,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: controller,
                        itemCount: movies.length,
                        itemBuilder: (_, index) =>
                            MovieWidget(movieVO: movies[index])),
                  ),
                ],
              ),
            ));
  }
}

class ProductionCompaniesItemView extends StatelessWidget {
  const ProductionCompaniesItemView(
      {Key? key, required this.productionCompaniesVO})
      : super(key: key);
  final List<ProductionCompaniesVO> productionCompaniesVO;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kSP10x),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EasyText(
            text: kProductionCompaniesText,
            fontSize: kFontSie23x,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            height: kSP15x,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: productionCompaniesVO
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(right: kSP20x),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: kProductionCompaniesImageHeight,
                              height: kProductionCompaniesImageHeight,
                              color: kPrimaryBackgroundColor,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(kSP30x),
                                child: CacheNetworkImageWidget(
                                  image: e.logoPath ?? '',
                                ),
                              ),
                            ),
                            EasyText(
                              text: e.name ?? '',
                              fontWeight: FontWeight.w600,
                              maxLine: 2,
                              color: kSecondaryTextColor,
                              fontSize: kFontSie15x,
                            )
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class TalentSquadItemView extends StatelessWidget {
  const TalentSquadItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<MovieDetailsBloc, List<CrewVO>?>(
      selector: (_, bloc) => bloc.getCrewVO,
      builder: (_, crewList, __) => (crewList == null)
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.all(kSP5x),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const EasyText(
                    text: kTalentSquadText,
                    fontSize: kFontSie23x,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: kSP15x,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: crewList
                            .map((e) => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CastAndCrewProfileNameWidget(
                                        name: e.name ?? '',
                                        profilePath: e.profilePath ?? '',
                                        titleText: 'Crew')
                                  ],
                                ))
                            .toList()),
                  ),
                ],
              ),
            ),
    );
  }
}

class StartCastItemView extends StatelessWidget {
  const StartCastItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<MovieDetailsBloc, List<CastVO>?>(
      selector: (_, bloc) => bloc.getCastVO,
      builder: (_, castList, __) => (castList == null)
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.all(kSP5x),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const EasyText(
                    text: kStarCastText,
                    fontSize: kFontSie23x,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: kSP15x,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: castList
                            .map((e) => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CastAndCrewProfileNameWidget(
                                        name: e.name ?? '',
                                        profilePath: e.profilePath ?? '',
                                        titleText: e.getGenderByActor())
                                  ],
                                ))
                            .toList()),
                  ),
                ],
              ),
            ),
    );
  }
}

class StoryLineItemView extends StatelessWidget {
  const StoryLineItemView({super.key, required this.overview});

  final String overview;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kSP5x),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EasyText(
            text: kStoryLineText,
            fontSize: kFontSie23x,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            height: kSP10x,
          ),
          EasyText(
            maxLine: 50,
            text: overview,
            fontWeight: FontWeight.w500,
            color: kSecondaryTextColor,
            fontSize: kFontSie15x,
          )
        ],
      ),
    );
  }
}

class DetailsMovieImageGenresItemView extends StatelessWidget {
  const DetailsMovieImageGenresItemView(
      {Key? key,
      required this.movieName,
      required this.movieImage,
      required this.onTapBack,
      required this.movieGenresAndRunTimList})
      : super(key: key);
  final String movieName;
  final String movieImage;
  final List<String> movieGenresAndRunTimList;
  final Function onTapBack;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: kPrimaryBackgroundColor,
      automaticallyImplyLeading: false,
      expandedHeight: kSliverAppBarActorDetailsHeight,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Hero(
          transitionOnUserGestures: true,
          tag: movieName,
          child: EasyText(
            text: movieName,
            maxLine: 2,
            fontSize: kFontSie18x,
            fontWeight: FontWeight.w700,
          ),
        ),
        background: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                transitionOnUserGestures: true,
                tag: movieImage,
                child: CacheNetworkImageWidget(
                  fit: BoxFit.fitHeight,
                  image: movieImage,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kSP10x, vertical: kSP70x),
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => onTapBack(),
                  child: const CircleAvatar(
                    radius: kBackButtonSize,
                    backgroundColor: kSecondaryBackgroundColor,
                    child: Icon(
                      Icons.arrow_back_outlined,
                      color: kPrimaryTextColor,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Wrap(
                  children:
                      List.generate(movieGenresAndRunTimList.length, (index) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    index == 0
                        ? const SizedBox.shrink()
                        : const EasyText(
                            text: ' |',
                            color: kSecondaryTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: kFontSie15x,
                          ),
                    const SizedBox(
                      width: kSP5x,
                    ),
                    EasyText(
                      text: movieGenresAndRunTimList[index],
                      color: kSecondaryTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: kFontSie15x,
                    )
                  ],
                );
              })),
            )
          ],
        ),
      ),
    );
  }
}
