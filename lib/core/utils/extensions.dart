
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '/config/di/app_initializer.dart';
import '/core/theme/theme.dart';

extension StringExtension on String {
  Text toText({
    
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 14,
    double textHeight = 24.0 / 14.0,
    Color? color,
    TextAlign? textAlign,
    FontStyle? fontStyle,
    TextOverflow? textOverflow,
  }) {
    return Text(
       this,
      textAlign: textAlign,
      softWrap: true,
      style: TextStyle(
          fontFamily: 'Outfit',
          fontWeight: fontWeight,
          height: textHeight,
          fontSize: fontSize.sp,
          fontStyle: fontStyle,
          color: color ?? navigatorKey.currentContext!.designSystem.text,
          overflow: textOverflow ?? TextOverflow.visible),
    );
  }

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  SvgPicture toSvg({
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    return SvgPicture.asset(
      'assets/vectors/$this.svg',
      width: width,
      height: height,
      // ignore: deprecated_member_use
      color: color,
      fit: fit ?? BoxFit.contain,
    );
  }

  Image pngPicture({
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    return Image.asset(
      'assets/images/$this.png',
      width: width,
      height: height,
      fit: fit,
    );
  }

}

extension GoRouterExtension on GoRouter {
  String location() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  }
}
