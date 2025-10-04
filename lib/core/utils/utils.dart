import 'dart:math';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do/features/home/presentation/bloc/category/category_cubit.dart';
import '../data/model/note_category.dart';
import '/core/theme/theme.dart';
import '/core/utils/extensions.dart';
import '/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final defaultPadding = REdgeInsets.symmetric(horizontal: 24, vertical: 16);


String randomText(int length) {
  const _chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  return List.generate(
      length, (index) => _chars[Random().nextInt(_chars.length)]).join();
}

class GenericErrorReloadWidget extends StatelessWidget {
  const   GenericErrorReloadWidget({super.key, this.message, this.onReload});

  final Function()? onReload;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          themeNotifier.value == lightTheme
              ? 'no_data_light'.toSvg()
              : 'no_data'.toSvg(),
          16.verticalSpace,
          (message ?? "no_data_found").toText(
           
            fontWeight: FontWeight.w500,
            // fontSize: 20.sp,
          ),
          if (onReload != null) SizedBox(height: 16.h),
          if (onReload != null)
            ElevatedButton(
              onPressed: onReload,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200.w, 56.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  side: BorderSide(
                    color: const Color(0xffE7E8EB),
                    width: 1.w,
                  ),
                ),
                backgroundColor: context.designSystem.iconBackground,
                shadowColor: Colors.transparent,
              ),
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Text(
                  "reload",
                  style: TextStyle(
                    color: context.designSystem.text,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ), // Custom text
            )
        ],
      ),
    );
  }
}

class GenericEmptyStateWidget extends StatelessWidget {
  const GenericEmptyStateWidget({super.key, this.message, this.onReload});

  final String? message;
  final Function()? onReload;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          themeNotifier.value == lightTheme
              ? 'no_data_light'.toSvg()
              : 'no_data'.toSvg(),
          16.verticalSpace,
          (message ?? "no_data_found").toText(
        
            fontWeight: FontWeight.w500,
            // fontSize: 20.sp,
          ),
          if (onReload != null) SizedBox(height: 16.h),
          if (onReload != null)
            ElevatedButton(
              onPressed: onReload,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200.w, 56.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  side: BorderSide(
                    color: const Color(0xffE7E8EB),
                    width: 1.w,
                  ),
                ),
                backgroundColor: context.designSystem.iconBackground,
                shadowColor: Colors.transparent,
              ),
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Text(
                  "reload",
                  style: TextStyle(
                    color: context.designSystem.text,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ), // Custom text
            )
        ],
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  String greeting() {
    final hour = this.hour;
    if (hour < 12) {
      return "good_morning";
    } else if (hour < 17) {
      return "good_afternoon";
    } else {
      return "good_evening";
    }
  }

  String toFormattedString(Locale locale) {
    return DateFormat.yMMMMd(locale.languageCode).format(this);
  }  
  

}
