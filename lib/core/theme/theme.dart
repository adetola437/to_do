import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/theme/colors.dart';

ThemeData lightTheme = ThemeData(
  dialogBackgroundColor: white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  //useMaterial3: false,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: white,
    dragHandleColor: tonedBlack,
  ),
  dialogTheme: DialogThemeData(
      backgroundColor: white,
      alignment: Alignment.center,
      titleTextStyle: TextStyle(
        color: greenGradient[0],
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      )),
  tabBarTheme: TabBarThemeData(
    labelPadding: REdgeInsets.symmetric(vertical: 0, horizontal: 10),
    // indicatorColor: Colors.transparent,

    dividerColor: Colors.transparent,
    indicator:
        BoxDecoration(borderRadius: BorderRadius.circular(6.r), color: white),
    unselectedLabelStyle:
        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
    unselectedLabelColor: textGrey.withOpacity(0.5),
    labelColor: text,
    labelStyle: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
    ),
  ),
  fontFamily: 'Outfit',
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: text,
      fontSize: 14.sp,
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: textGrey,
  ),
  bottomAppBarTheme: const BottomAppBarThemeData(
      surfaceTintColor: Colors.white, color: Colors.white),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 48.sp),
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey;
      } else if (states.contains(MaterialState.selected)) {
        return const Color(0xff3C7F22);
      } else {
        return Colors.transparent;
      }
    }),
    checkColor: const MaterialStatePropertyAll(Colors.white),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.r),
    ),
    side: BorderSide(
      color: const Color(0xff6D758F),
      width: 1.w,
    ),
  ),
  extensions: [
    DesignSystem(
        primary: primary,
        text: text,
        lightBackground: lightBackground,
        stroke: stroke,
        secondaryColor: secondaryColor,
        subText: subText,
        white: white,
        black: black,
        tonedBlack: tonedBlack,
        greenGradient: greenGradient,
        defaultShadow: defaultShadow,
        defaultDecoration: defaultDecoration,
        secondaryText: secondaryText,
        iconBackground: iconBackGround)
  ],
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xfff9f9f9),
    hintStyle: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: const Color(0xff6D758F),
    ),
    contentPadding: REdgeInsets.all(16),
    isDense: false,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color(0xffE7E8EB),
        width: 1.w,
      ),
      borderRadius: BorderRadius.circular(12.r),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color(0xff6D758F).withOpacity(0.5),
        width: 1.w,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red.withOpacity(0.5),
        width: 1.w,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color(0xff6D758F).withOpacity(0.5),
        width: 1.w,
      ),
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    surfaceTintColor: Colors.white,
    titleTextStyle: TextStyle(
      color: text,
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
    ),
  ),
);

class DesignSystem extends ThemeExtension<DesignSystem> {
  final Color? primary;
  final Color? text;
  final Color? lightBackground;
  final Color? stroke;
  final Color? secondaryColor;
  final Color? subText;
  final Color? white;
  final Color? black;
  final Color? tonedBlack;
  final Color? secondaryText;
  final Color? iconBackground;

  final List<Color>? greenGradient;
  final List<Color>? primaryGradient;
  final List<BoxShadow>? defaultShadow;
  final BoxDecoration? defaultDecoration;

  const DesignSystem(
      {this.primary,
      this.primaryGradient,
      this.text,
      this.lightBackground,
      this.stroke,
      this.secondaryColor,
      this.subText,
      this.white,
      this.black,
      this.tonedBlack,
      this.greenGradient,
      this.defaultShadow,
      this.defaultDecoration,
      this.secondaryText,
      this.iconBackground});

  @override
  ThemeExtension<DesignSystem> copyWith({
    Color? primary,
    Color? text,
    Color? lightBackground,
    Color? stroke,
    Color? secondaryColor,
    Color? subText,
    Color? white,
    Color? black,
    Color? tonedBlack,
    Color? primaryColor,
    Color? iconBackground,
    List<Color>? greenGradient,
    List<BoxShadow>? defaultShadow,
    BoxDecoration? defaultDecoration,
    Color? secondaryText,
  }) {
    return DesignSystem(
        primary: primary ?? this.primary,
        text: text ?? this.text,
        lightBackground: lightBackground ?? this.lightBackground,
        stroke: stroke ?? this.stroke,
        secondaryColor: secondaryColor ?? this.secondaryColor,
        subText: subText ?? this.subText,
        white: white ?? this.white,
        black: black ?? this.black,
        tonedBlack: tonedBlack ?? this.tonedBlack,
        greenGradient: greenGradient ?? this.greenGradient,
        defaultShadow: defaultShadow ?? this.defaultShadow,
        defaultDecoration: defaultDecoration ?? this.defaultDecoration,
        secondaryText: secondaryText ?? this.secondaryText,
        iconBackground: iconBackground ?? this.iconBackground);
  }

  @override
  DesignSystem lerp(ThemeExtension<DesignSystem>? other, double t) {
    if (other is DesignSystem) {
      return DesignSystem(
        primary: Color.lerp(primary, other.primary, t),
        text: Color.lerp(text, other.text, t),
        lightBackground: Color.lerp(lightBackground, other.lightBackground, t),
        stroke: Color.lerp(stroke, other.stroke, t),
        secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
        subText: Color.lerp(subText, other.subText, t),
        white: Color.lerp(white, other.white, t),
        black: Color.lerp(black, other.black, t),
        tonedBlack: Color.lerp(tonedBlack, other.tonedBlack, t),
        greenGradient: greenGradient,
        defaultShadow: defaultShadow,
        defaultDecoration: defaultDecoration,
        secondaryText: Color.lerp(secondaryText, other.secondaryText, t),
        iconBackground: Color.lerp(iconBackground, other.iconBackground, t),
      );
    }
    return DesignSystem(
        primary: primary,
        text: text,
        lightBackground: lightBackground,
        stroke: stroke,
        secondaryColor: secondaryColor,
        subText: subText,
        white: white,
        black: black,
        tonedBlack: tonedBlack,
        greenGradient: greenGradient,
        defaultShadow: defaultShadow,
        defaultDecoration: defaultDecoration,
        secondaryText: secondaryText,
        iconBackground: iconBackground);
  }
}

extension DesignSystemExtension on BuildContext {
  DesignSystem get designSystem => Theme.of(this).extension<DesignSystem>()!;
  ThemeData get theme => Theme.of(this);
}

ThemeData darkTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: tonedBlack,
    dragHandleColor: white,
  ),
  dialogBackgroundColor: const Color(0xff111116),
  dialogTheme: DialogThemeData(
    backgroundColor: const Color(0xff111116),
    alignment: Alignment.center,
    titleTextStyle: TextStyle(
      color: greenGradient[0],
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
    ),
  ),
  tabBarTheme: TabBarThemeData(
    labelPadding: REdgeInsets.symmetric(vertical: 0, horizontal: 10),
    dividerColor: Colors.transparent,
    indicator: BoxDecoration(
      color: tonedBlack,
      borderRadius: BorderRadius.circular(6.r),
    ),
    unselectedLabelStyle:
        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
    unselectedLabelColor: textDark.withOpacity(0.5),
    labelColor: textDark,
    labelStyle: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
    ),
  ),
  fontFamily: 'Outfit',
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: textGrey,
  ),
  bottomAppBarTheme: const BottomAppBarThemeData(
    surfaceTintColor: Color(0xff111116),
    color: Color(0xff111116),
  ),
  textTheme: TextTheme(
    titleMedium: TextStyle(
      color: white,
    ),
  ),
  canvasColor: tonedBlack,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 48.sp),
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey;
      } else if (states.contains(MaterialState.selected)) {
        return const Color(0xff3C7F22);
      } else {
        return Colors.white;
      }
    }),
    checkColor: const MaterialStatePropertyAll(Colors.white),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.r),
    ),
    side: BorderSide(
      color: const Color(0xff6D758F),
      width: 1.w,
    ),
  ),
  extensions: [
    DesignSystem(
      primary: primary,
      text: textDark,
      lightBackground: lightBackground,
      stroke: stroke,
      secondaryColor: secondaryColor,
      subText: subText,
      white: white,
      black: black,
      tonedBlack: tonedBlack,
      greenGradient: greenGradient,
      defaultShadow: defaultShadow,
      defaultDecoration: defaultDecorationDark,
      secondaryText: secondaryTextDark,
      iconBackground: iconBackGroundDark,
    ),
  ],
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xff1B1B1F),
    hintStyle: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      height: 24.0 / 12.0,
      color: const Color(0xffC7CFE9),
    ),
    contentPadding: REdgeInsets.all(16),
    isDense: false,
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0xff25252D),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(12.r),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color(0xff25252D).withOpacity(0.5),
        width: 1,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red.withOpacity(0.5),
        width: 1.w,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color(0xff25252D).withOpacity(0.5),
        width: 1,
      ),
    ),
  ),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: textDark,
      fontSize: 14.sp,
    ),
  ),
  scaffoldBackgroundColor: const Color(0xff111116),
  appBarTheme: AppBarTheme(
    surfaceTintColor: const Color(0xff111116),
    color: const Color(0xff111116),
    iconTheme: IconThemeData(
      color: white,
    ),
    titleTextStyle: TextStyle(
      color: textDark,
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
    ),
  ),
);
