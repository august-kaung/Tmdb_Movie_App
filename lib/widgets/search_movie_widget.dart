import 'package:flutter/material.dart';
import 'package:tmdb_app/constant/colors.dart';
import 'package:tmdb_app/constant/dimens.dart';
import 'package:tmdb_app/constant/strings.dart';

class SearchMovieWidget extends StatelessWidget {
  const SearchMovieWidget(
      {super.key,
      required this.onTap,
      this.isEnable = false,
      this.isAutoFocus = false,
      this.onChange});

  final Function onTap;
  final bool isEnable;
  final bool isAutoFocus;
  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSP10x),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            style: const TextStyle(color: kPrimaryTextColor),
            onChanged: (text) => onChange!(text),
            autofocus: isAutoFocus,
            enabled: isEnable,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kSP20x),
                ),
                hintStyle: const TextStyle(color: kSecondaryTextColor),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(kSP20x)),
                filled: true,
                fillColor: kTextFieldBackgroundColor,
                hintText: kSearchMoviesText),
          )),
          const SizedBox(
            width: kSP20x,
          ),
          GestureDetector(
            onTap: () => onTap(),
            child: Container(
              padding: const EdgeInsets.all(kSP10x),
              decoration: BoxDecoration(
                color: kSecondaryBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.search,
                size: kSearchIconSize,
                color: kPrimaryTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
