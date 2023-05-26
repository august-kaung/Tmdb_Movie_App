import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/bloc/actor_details_page_bloc.dart';
import 'package:tmdb_app/constant/dimens.dart';
import 'package:tmdb_app/constant/strings.dart';
import 'package:tmdb_app/data/vos/actor_details_vo/actor_details_vo.dart';
import 'package:tmdb_app/utils/extensions_utils.dart';
import 'package:tmdb_app/widgets/loading_widget.dart';

import '../constant/colors.dart';
import '../data/vos/movie_vo/movie_vo.dart';
import '../view_items/actor_details_view_items/actor_details_view_items.dart';
import '../widgets/easy_text.dart';
import '../widgets/movie_widget.dart';

class ActorDetailsPage extends StatelessWidget {
  const ActorDetailsPage({Key? key, required this.id, required this.movieList})
      : super(key: key);
  final int id;
  final List<MovieVO> movieList;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ActorDetailsBLoc>(
      create: (_) => ActorDetailsBLoc(id),
      child: Selector<ActorDetailsBLoc, ActorDetailsVO?>(
          selector: (_, bloc) => bloc.getActorDetailsVO,
          builder: (_, actor, __) {
            if (actor == null) {
              return const LoadingWidget();
            }
            return Scaffold(
              backgroundColor: kPrimaryBackgroundColor,
              body: NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) => [
                            ActorDetailsImageView(
                                actorName: actor.name ?? '',
                                onTapBack: () {
                                  context.navigateBack(context);
                                },
                                profileImage: actor.profilePath ?? '')
                          ],
                  body: ListView(
                    children: [
                      ///Biography Session
                      BiographyItemView(biography: actor.biography ?? ''),
                      const SizedBox(
                        height: kSP20x,
                      ),

                      ///More Information(DOB,DeadDate,PlaceOfBirth,Gender,ETC...) Session
                      MoreInformationItemView(
                        birthDay: actor.birthday ?? '',
                        deadDay: actor.deathDay ?? '',
                        gender: actor.getGender(),
                        placeOfBirth: actor.placeOfBirth ?? '',
                        popularity: actor.popularity ?? 0.0,
                      ),
                      const SizedBox(
                        height: kSP20x,
                      ),

                      ///Known For Movie Session
                      KnowForMovieItemView(movieList: movieList),
                      const SizedBox(
                        height: kSP30x,
                      ),
                    ],
                  )),
            );
          }),
    );
  }
}

class KnowForMovieItemView extends StatelessWidget {
  const KnowForMovieItemView({
    super.key,
    required this.movieList,
  });

  final List<MovieVO> movieList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kKnowForMovieViewHeight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: kSP10x),
            child: EasyText(
              text: kKnownForText,
              fontWeight: FontWeight.w600,
              fontSize: kFontSie24x,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: kSP10x),
            child: Divider(
              color: kSecondaryTextColor,
              thickness: 2,
            ),
          ),
          const SizedBox(
            height: kSP10x,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
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
