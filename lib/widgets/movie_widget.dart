import 'package:flutter/material.dart';
import 'package:tmdb_app/constant/colors.dart';
import 'package:tmdb_app/constant/dimens.dart';
import 'package:tmdb_app/data/vos/movie_vo/movie_vo.dart';
import 'package:tmdb_app/pages/details_page.dart';
import 'package:tmdb_app/utils/extensions_utils.dart';
import 'package:tmdb_app/view_items/home_page_view_items/home_page_view_items.dart';
import 'package:tmdb_app/widgets/easy_text.dart';
import 'package:tmdb_app/widgets/gradient_widget.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget({Key? key, required this.movieVO}) : super(key: key);
  final MovieVO movieVO;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigateToNextScreen(
            context, DetailsPage(movieID: movieVO.id ?? 0));
      },
      child: Container(
        width: kMovieWidth,
        margin: const EdgeInsets.only(right: kSP20x),
        child: Stack(
          children: [
            Positioned.fill(
                child: BannerAndMovieGenresImageWidget(
                    imageURL: movieVO.posterPath ?? '')),
            const GradientWidget(),
            Align(
              alignment: Alignment.bottomLeft,
              child: MovieNameRatingAndVoteView(
                movieName: movieVO.originalTitle ?? '',
                rate: movieVO.voteAverage ?? 0.0,
                voteCount: movieVO.voteCount ?? 0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MovieNameRatingAndVoteView extends StatelessWidget {
  const MovieNameRatingAndVoteView(
      {super.key,
      required this.movieName,
      required this.rate,
      required this.voteCount});

  final String movieName;
  final double rate;
  final int voteCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kSP10x),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EasyText(
            maxLine: 3,
            fontSize: kFontSie18x,
            fontWeight: FontWeight.w700,
            text: movieName,
          ),
          const SizedBox(
            height: kSP10x,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star_border_purple500_outlined,
                color: Colors.amber,
              ),
              const SizedBox(
                width: kSP5x,
              ),
              EasyText(
                color: kSecondaryTextColor,
                text: rate.toString(),
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                width: kSP30x,
              ),
              EasyText(
                color: kSecondaryTextColor,
                text: '$voteCount vote'.addS(),
                fontWeight: FontWeight.w600,
              ),
            ],
          )
        ],
      ),
    );
  }
}
