import 'package:flutter/material.dart';

Color primary = const Color(0xff007F2D);
Color text = const Color(0xff010202);
Color textDark = const Color(0xffC7CFE9);
Color lightBackground = const Color(0xffEBECEC);
Color stroke = const Color(0xff939595);
Color secondaryColor = const Color(0xffB5B6B6);
Color subText = const Color(0xff858686);
Color white = const Color(0xffffffff);
Color black = const Color(0xff000000);
Color tonedBlack = const Color(0xff2B2B2B);
Color green = const Color(0xff00FF00);
Color orange = const Color(0xffCA6128);
Color secondaryText = const Color(0xff202020);
Color secondaryTextDark = const Color(0xfffafafa);
Color iconBackGroundDark = const Color(0xff2C2C33);
Color iconBackGround = const Color(0xffffffff);
// Color orange =  Color(0xffCA6128);
List<Color> greenGradient = [
  const Color(0xff3C7F22),
  const Color(0xff4CA62B),
];
final List<Color> primaryGradient = [primary, lightGreen];
Color textGrey = const Color(0xff6D758F);
Color grey = const Color(0xff828282);
Color text2 = const Color(0xff616161);
Color text3 = const Color(0xffc2c2c2);
Color lightGreen = const Color(0xff289551);

List<BoxShadow> defaultShadow = [
  BoxShadow(
    color: const Color(0xff393B3D).withOpacity(0.04),
    blurRadius: 20,
    spreadRadius: 0,
    offset: const Offset(0, 2),
  )
];

BoxDecoration defaultDecoration = BoxDecoration(
  color: white,
  borderRadius: BorderRadius.circular(16),
  boxShadow: defaultShadow,
);

BoxDecoration defaultDecorationDark = BoxDecoration(
  color: tonedBlack,
  borderRadius: BorderRadius.circular(16),
  boxShadow: defaultShadow,
);


  // static const Color primaryColor = Color(0xFF0066FF);
  // static const Color white = Color(0xFFF4F4F4);
  // static const Color hintText = Color(0xFF575B66);
  // static const Color walletBackground = Color(0xFF131316);
  // static const Color backGround = Color(0xFF131316);
  // static const Color grad1= Color(0xFF3C7F22);
  // static const Color darkGrey = Color.fromRGBO(185, 193, 217, 1);
  // static const Color grayText = Color(0xFF6D758F);
  // static const Color grey = Color(0xFF1A171F);
  // static const Color dark = Color(0xFF070C0C);
  // static const Color bgColor = Color(0xFFFAFBFF);
  // static const Color grad2 = Color(0xFF4CA62B);