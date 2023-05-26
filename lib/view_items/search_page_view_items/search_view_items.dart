import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/bloc/search_page_bloc.dart';
import 'package:tmdb_app/constant/colors.dart';
import 'package:tmdb_app/constant/dimens.dart';
import 'package:tmdb_app/constant/strings.dart';
import 'package:tmdb_app/data/vos/movie_vo/movie_vo.dart';
import 'package:tmdb_app/pages/details_page.dart';
import 'package:tmdb_app/utils/extensions_utils.dart';
import 'package:tmdb_app/widgets/cache_network_image_widget.dart';
import 'package:tmdb_app/widgets/easy_text.dart';
import 'package:tmdb_app/widgets/loading_widget.dart';

import '../../widgets/search_movie_widget.dart';

class SearchTextFieldView extends StatelessWidget {
  const SearchTextFieldView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SearchMovieWidget(
      isAutoFocus: true,
      onChange: (text) {
        context.getSearchPageBlocInstance().search(text);
      },
      isEnable: true,
      onTap: () {},
    );
  }
}

class SearchListItemView extends StatelessWidget {
  const SearchListItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<SearchPageBloc, ScrollController>(
      selector: (_, bloc) => bloc.getScrollControllerForSearchHistory,
      builder: (_, controller, __) => Selector<SearchPageBloc, List<MovieVO>?>(
          shouldRebuild: (pre, next) => pre != next,
          selector: (_, bloc) => bloc.getSearchMovieList,
          builder: (_, searchMovieList, __) {
            if (searchMovieList == null || searchMovieList.isEmpty) {
              return const SizedBox.shrink();
            }
            return SearchListView(
              searchMoviesList: searchMovieList,
              controller: controller,
            );
          }),
    );
  }
}

class SearchListView extends StatelessWidget {
  const SearchListView(
      {Key? key, required this.searchMoviesList, required this.controller})
      : super(key: key);
  final List<MovieVO> searchMoviesList;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Selector<SearchPageBloc, bool>(
      selector: (_, bloc) => bloc.isSearching,
      builder: (_, isSearching, __) => (isSearching)
          ? const LoadingWidget()
          : ListView.separated(
              controller: controller,
              padding: const EdgeInsets.symmetric(
                  horizontal: kSP5x, vertical: kSP10x),
              itemBuilder: (_, index) {
                return GestureDetector(
                    onTap: () {
                      context.navigateToNextScreen(
                          context,
                          DetailsPage(
                              movieID: searchMoviesList[index].id ?? 0));
                    },
                    child: SearchMovieView(movie: searchMoviesList[index]));
              },
              separatorBuilder: (_, index) => const SizedBox(
                    height: kSP10x,
                  ),
              itemCount: searchMoviesList.length),
    ));
  }
}

class BackButtonItemView extends StatelessWidget {
  const BackButtonItemView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
            onPressed: () {
              context.navigateBack(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              color: kSecondaryBackgroundColor,
            ),
            label: const EasyText(
              text: kBackText,
              fontSize: kFontSie15x,
              fontWeight: FontWeight.w500,
              color: kSecondaryBackgroundColor,
            ))
      ],
    );
  }
}

class SearchMovieView extends StatelessWidget {
  const SearchMovieView({Key? key, required this.movie}) : super(key: key);
  final MovieVO movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kTextFieldBackgroundColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CacheNetworkImageWidget(
            fit: BoxFit.fitWidth,
            image: movie.posterPath ?? '',
            width: 80,
            height: 80,
          ),
          Expanded(
            child: SearchMovieDateAndGenreView(
              movieOverView: movie.overview ?? '',
              movieTitle: movie.originalTitle ?? '',
              year: movie.releaseDate == null ||
                      (movie.releaseDate?.isEmpty ?? true)
                  ? DateTime.now().year.toString()
                  : DateTime.parse(movie.releaseDate ?? '').year.toString(),
            ),
          )
        ],
      ),
    );
  }
}

class SearchMovieDateAndGenreView extends StatelessWidget {
  const SearchMovieDateAndGenreView(
      {Key? key,
      required this.movieOverView,
      required this.movieTitle,
      required this.year})
      : super(key: key);
  final String movieTitle;
  final String year;
  final String movieOverView;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: EasyText(
        text: movieTitle,
      ),
      subtitle: EasyText(
        text: (movieOverView.isEmpty) ? "None" : movieOverView,
      ),
      trailing: Container(
        padding: const EdgeInsets.all(kSP5x),
        color: kSecondaryBackgroundColor,
        child: EasyText(
          text: year,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
