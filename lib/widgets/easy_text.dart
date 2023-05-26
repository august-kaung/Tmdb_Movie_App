import 'package:flutter/material.dart';
import 'package:tmdb_app/constant/colors.dart';
import 'package:tmdb_app/constant/dimens.dart';
import 'package:tmdb_app/utils/font_typography_utils.dart';

class EasyText extends StatelessWidget {
  const EasyText(
      {Key? key,
      required this.text,
      this.fontSize = kFontSie14x,
      this.fontWeight = FontWeight.w400,
      this.color = kPrimaryTextColor,
      this.decoration = TextDecoration.none,
        this.maxLine,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextDecoration decoration;
  final TextOverflow overflow;
  final int ?maxLine;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      style: TextStyle(
          fontSize: FontTypography.getFontSizeByDevice(context, fontSize),
          fontWeight: fontWeight,
          color: color,
          decoration: decoration,
          overflow: overflow),
    );
  }
}
