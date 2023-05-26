import 'package:flutter/material.dart';
import 'package:tmdb_app/constant/colors.dart';
import 'package:tmdb_app/constant/dimens.dart';
import 'package:tmdb_app/constant/strings.dart';
import 'package:tmdb_app/widgets/cache_network_image_widget.dart';
import 'package:tmdb_app/widgets/easy_text.dart';
import 'package:tmdb_app/widgets/gradient_widget.dart';
import 'package:tmdb_app/widgets/info_widget.dart';

class ActorDetailsImageView extends StatelessWidget {
  const ActorDetailsImageView(
      {Key? key,
      required this.onTapBack,
      required this.profileImage,
      required this.actorName})
      : super(key: key);
  final String profileImage;
  final Function onTapBack;
  final String actorName;

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
          tag: actorName,
          child: EasyText(
            text: actorName,
            fontSize: kFontSie21x,
            fontWeight: FontWeight.w700,
          ),
        ),
        background: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                transitionOnUserGestures: true,
                tag: profileImage,
                child: CacheNetworkImageWidget(
                  fit: BoxFit.fitWidth,
                  image: profileImage,
                ),
              ),
            ),
            const GradientWidget(
              endColor: Colors.black54,
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
            )
          ],
        ),
      ),
    );
  }
}

class BiographyItemView extends StatelessWidget {
  const BiographyItemView({Key? key, required this.biography})
      : super(key: key);
  final String biography;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kSP10x),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EasyText(
            text: kBiographyText,
            fontWeight: FontWeight.w600,
            fontSize: kFontSie24x,
          ),
          const Divider(
            color: kSecondaryTextColor,
            thickness: 2,
          ),
          const SizedBox(
            height: kSP10x,
          ),
          EasyText(
            maxLine: 50,
            text: biography,
            fontWeight: FontWeight.w400,
            color: kSecondaryTextColor,
            fontSize: kFontSie18x,
          ),
        ],
      ),
    );
  }
}

class MoreInformationItemView extends StatelessWidget {
  const MoreInformationItemView(
      {Key? key,
      required this.popularity,
      required this.birthDay,
      required this.deadDay,
      required this.gender,
      required this.placeOfBirth})
      : super(key: key);
  final String deadDay;
  final String birthDay;
  final String gender;
  final String placeOfBirth;
  final double popularity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kSP10x),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EasyText(
            text: kMoreInformationText,
            fontWeight: FontWeight.w600,
            fontSize: kFontSie24x,
          ),
          const Divider(
            color: kSecondaryTextColor,
            thickness: 2,
          ),
          const SizedBox(
            height: kSP10x,
          ),
          InfoWidget(
            firstInfoText: kPlaceOfBirthText,
            secondInfoText: placeOfBirth,
          ),
          const SizedBox(
            height: kSP10x,
          ),
          InfoWidget(
            firstInfoText: kBirthDayText,
            secondInfoText: birthDay,
          ),
          const SizedBox(
            height: kSP10x,
          ),
          InfoWidget(
            firstInfoText: kDeadDayText,
            secondInfoText: deadDay.isEmpty ? "-" : deadDay,
          ),
          const SizedBox(
            height: kSP10x,
          ),
          InfoWidget(
            firstInfoText: kGenderText,
            secondInfoText: gender,
          ),
          const SizedBox(
            height: kSP10x,
          ),
          InfoWidget(
            firstInfoText: kPopularityText,
            secondInfoText: popularity.toString(),
          ),
        ],
      ),
    );
  }
}
