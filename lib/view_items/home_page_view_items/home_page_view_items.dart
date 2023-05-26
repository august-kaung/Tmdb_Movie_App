import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/bloc/home_page_bloc.dart';
import 'package:tmdb_app/constant/colors.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/constant/dimens.dart';
import 'package:tmdb_app/constant/strings.dart';
import 'package:tmdb_app/data/vos/actor_vo/actor_vo.dart';
import 'package:tmdb_app/data/vos/actor_vo/know_for_vo.dart';
import 'package:tmdb_app/utils/extensions_utils.dart';
import 'package:tmdb_app/widgets/cache_network_image_widget.dart';
import 'package:tmdb_app/widgets/easy_text.dart';
import 'package:tmdb_app/widgets/loading_widget.dart';
import 'package:tmdb_app/widgets/movie_widget.dart';

import '../../data/vos/genre_vo/genre_vo.dart';
import '../../data/vos/movie_vo/movie_vo.dart';
import '../../widgets/gradient_widget.dart';

class HorizontalGenreListItemView extends StatelessWidget {
  const HorizontalGenreListItemView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, List<GenreVO>?>(
        shouldRebuild: (pre, next) => pre != next,
        selector: (_, bloc) => bloc.getGenreList,
        builder: (_, genreList, __) {
          if (genreList == null) {
            return const Center(child: EasyText(text: kNoDataText));
          }
          if (genreList.isEmpty) {
            return const LoadingWidget();
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: genreList
                  .map((e) => GestureDetector(
                        onTap: () {
                          context
                              .getHomePageBlocInstance()
                              .setGenreTypeSelect(e.id ?? 0);
                        },
                        child: SelectGenreView(
                            isSelect: e.isSelect, genreName: e.name ?? ''),
                      ))
                  .toList(),
            ),
          );
        });
  }
}

class SelectGenreView extends StatelessWidget {
  const SelectGenreView(
      {Key? key, required this.isSelect, required this.genreName})
      : super(key: key);
  final String genreName;
  final bool isSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: kSP10x),
      padding: const EdgeInsets.all(kSP10x),
      decoration: (isSelect)
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(kSP5x),
              color: kSecondaryBackgroundColor,
            )
          : null,
      child: EasyText(
        text: genreName,
      ),
    );
  }
}

class BannerMovieItemView extends StatelessWidget {
  const BannerMovieItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, List<MovieVO>?>(
        shouldRebuild: (pre, next) => pre != next,
        selector: (_, bloc) => bloc.getBannerMovieList,
        builder: (_, movieList, __) {
          if (movieList == null) {
            return const SizedBox(
                height: kDefaultSize,
                child: Center(child: EasyText(text: kNoDataText)));
          }
          if (movieList.isEmpty) {
            return const SizedBox(height: kDefaultSize, child: LoadingWidget());
          }
          return CarouselSlider.builder(
              options: CarouselOptions(
                aspectRatio: 1,
                autoPlay: true,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              itemCount: movieList.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      BannerMovieView(
                        movieVO: movieList[itemIndex],
                      ));
        });
  }
}

class BannerMovieView extends StatelessWidget {
  const BannerMovieView({super.key, required this.movieVO});

  final MovieVO movieVO;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: BannerAndMovieGenresImageWidget(
          imageURL: movieVO.posterPath ?? '',
        )),
        const GradientWidget(),
        Align(
            alignment: Alignment.center,
            child: GestureDetector(
              child: Container(
                width: kPlayButtonSize,
                height: kPlayButtonSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kSP30x),
                  color: kSecondaryBackgroundColor,
                ),
                child: const Icon(
                  Icons.play_arrow_outlined,
                  color: kSecondaryTextColor,
                ),
              ),
            ))
      ],
    );
  }
}

class BannerAndMovieGenresImageWidget extends StatelessWidget {
  const BannerAndMovieGenresImageWidget({super.key, required this.imageURL});

  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kSP20x),
      child: CacheNetworkImageWidget(
        image: imageURL,
        fit: BoxFit.cover,
      ),
    );
  }
}

class MovieByGenreItemView extends StatelessWidget {
  const MovieByGenreItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, List<MovieVO>?>(
        shouldRebuild: (pre, next) => pre != next,
        selector: (_, bloc) => bloc.getGenreMovieList,
        builder: (_, movieList, __) {
          if (movieList == null) {
            return const Center(child: EasyText(text: kNoDataText));
          }
          if (movieList.isEmpty) {
            return const LoadingWidget();
          }
          return HorizontalMovieByGenreListView(movieList: movieList);
        });
  }
}

class HorizontalMovieByGenreListView extends StatelessWidget {
  const HorizontalMovieByGenreListView({Key? key, required this.movieList})
      : super(key: key);
  final List<MovieVO> movieList;

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, ScrollController>(
      selector: (_, bloc) => bloc.getScrollControllerForMovieByGenres,
      builder: (_, controller, __) => ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: controller,
        itemCount: movieList.length,
        itemBuilder: (_, index) => MovieWidget(
          movieVO: movieList[index],
        ),
      ),
    );
  }
}

class YouMayLikeItemView extends StatelessWidget {
  const YouMayLikeItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, List<MovieVO>?>(
        selector: (_, bloc) => bloc.getNowPlayingMovieList,
        builder: (_, nowPlayingMoviesList, __) {
          if (nowPlayingMoviesList == null) {
            return const Center(child: EasyText(text: kNoDataText));
          }
          if (nowPlayingMoviesList.isEmpty) {
            return const LoadingWidget();
          }
          return HorizontalYouMayLikeMovieView(movieList: nowPlayingMoviesList);
        });
  }
}

class HorizontalYouMayLikeMovieView extends StatelessWidget {
  const HorizontalYouMayLikeMovieView({Key? key, required this.movieList})
      : super(key: key);
  final List<MovieVO> movieList;

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, ScrollController>(
      selector: (_, bloc) => bloc.getScrollControllerForGetNowPLayingMovies,
      builder: (_, controller, __) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EasyText(
            text: kYouMayLikeText,
            fontSize: kFontSie21x,
            fontWeight: FontWeight.w500,
            color: kPrimaryTextColor,
          ),
          const SizedBox(
            height: kSP20x,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: controller,
              itemCount: movieList.length,
              itemBuilder: (_, index) => MovieWidget(
                movieVO: movieList[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PopularMoviesItemView extends StatelessWidget {
  const PopularMoviesItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, List<MovieVO>?>(
        selector: (_, bloc) => bloc.getPopularMoviesList,
        builder: (_, popularMoviesList, __) {
          if (popularMoviesList == null) {
            return const Center(child: EasyText(text: kNoDataText));
          }
          if (popularMoviesList.isEmpty) {
            return const LoadingWidget();
          }
          return HorizontalPopularMovieView(movieList: popularMoviesList);
        });
  }
}

class HorizontalPopularMovieView extends StatelessWidget {
  const HorizontalPopularMovieView({Key? key, required this.movieList})
      : super(key: key);
  final List<MovieVO> movieList;

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, ScrollController>(
      selector: (_, bloc) => bloc.getScrollControllerForPopularMovies,
      builder: (_, controller, __) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EasyText(
            text: kPopularMoviesText,
            fontSize: kFontSie21x,
            fontWeight: FontWeight.w500,
            color: kPrimaryTextColor,
          ),
          const SizedBox(
            height: kSP20x,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: controller,
              itemCount: movieList.length,
              itemBuilder: (_, index) => MovieWidget(
                movieVO: movieList[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActorListItemView extends StatelessWidget {
  const ActorListItemView({Key? key, required this.onTapActor})
      : super(key: key);
  final Function(int, List<KnownForVO>) onTapActor;

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageBloc, List<ActorVO>?>(
        selector: (_, bloc) => bloc.getActorList,
        builder: (_, actorList, __) {
          if (actorList == null) {
            return const Center(child: EasyText(text: kNoDataText));
          }
          if (actorList.isEmpty) {
            return const LoadingWidget();
          }
          return CarouselSlider.builder(
              options: CarouselOptions(
                onPageChanged: (index, _) {
                  context.getHomePageBlocInstance().fetchMoreActor(index);
                },
                aspectRatio: 1,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              itemCount: actorList.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      GestureDetector(
                          onTap: () => onTapActor(actorList[itemIndex].id ?? 0,
                              actorList[itemIndex].knownFor ?? []),
                          child: ActorView(actor: actorList[itemIndex])));
        });
  }
}

class ActorView extends StatelessWidget {
  const ActorView({Key? key, required this.actor}) : super(key: key);
  final ActorVO actor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: ClipRRect(
          borderRadius: BorderRadius.circular(kSP20x),
          child: Hero(
            transitionOnUserGestures: true,
            tag: actor.profilePath ?? '',
            child: CacheNetworkImageWidget(
              image: actor.profilePath ?? '',
              fit: BoxFit.fitWidth,
            ),
          ),
        )),
        const GradientWidget(),
        Padding(
          padding: const EdgeInsets.only(bottom: kSP10x),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Hero(
              transitionOnUserGestures: true,
              tag: actor.name ?? '',
              child: EasyText(
                text: actor.name ?? '',
                fontSize: kFontSie21x,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
