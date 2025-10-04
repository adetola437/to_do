import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '/core/utils/extensions.dart';

abstract class IWidgetHelper {
  Future showSuccessDialog(
    String message,
    BuildContext context, {
    bool popAfter = false,
    String title = 'success',
    String label = 'close',
    bool dismiss = true,
  });
  Future showErrorDialog(
    String message,
    BuildContext context, {
    bool popAfter = false,
    String title = 'an_error_occured',
    String label = 'close',
  });
}

class WidgetHelper implements IWidgetHelper {
  @override
  Future showErrorDialog(
    String message,
    BuildContext context, {
    bool popAfter = false,
    String title = 'an_error_occured',
    String label = 'close',
  }) async {
    late Flushbar flush;
    flush = Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 16.r),
      padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 16.sp),
      borderRadius: BorderRadius.circular(16.r),

      title: title,
      titleColor: Color(0xffCD0000),
      titleSize: 16.sp,
      // messageText: message.toText(),
      messageSize: 14.sp,
      messageColor: Color(0xffCD0000),
      backgroundColor: Color(0xffFFEBEB),
      flushbarPosition: FlushbarPosition.TOP,
      mainButton: TextButton(
        onPressed: () {
          flush.dismiss(popAfter);
        },
        child: 'close'.toText(color: Color(0xffCD0000)),
      ),
      flushbarStyle: FlushbarStyle.FLOATING,
      message: message.isEmpty ? 'something_went_wrong' : message,
      // isDismissible: false,
      blockBackgroundInteraction: true,
      // duration: popAfter ? Duration(seconds: 3) : null,
    );
    return flush
      ..show(context).then((value) {
        if (popAfter) {
          context.pop();
        }
      });
  }

  @override
  Future showSuccessDialog(
    String message,
    BuildContext context, {
    bool popAfter = false,
    String title = 'Success',
    String label = 'close',
    bool dismiss = false,
  }) async {
    late Flushbar flush;
    flush = Flushbar(
      margin: REdgeInsets.symmetric(horizontal: 18.r),
      borderRadius: BorderRadius.circular(16.r),
      // borderColor: context.customColors.green!,
      icon: SvgPicture.asset(
        'assets/vectors/check.svg',
        fit: BoxFit.scaleDown,
      ),
      title: title, titleSize: 16.sp,
      messageSize: 14.sp,
      titleColor: Color(0xff0C6E27),
      messageColor: Color(0xff0C6E27),
      backgroundColor: Color(0xffE3FCEA),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      message: message,
      duration: popAfter
          ? dismiss
              ? const Duration(seconds: 3)
              : null
          : null,
      mainButton: TextButton(
        onPressed: () {
          flush.dismiss(popAfter);
        },
        child: 'close'.toText(
          color: Color(0xff0C6E27),
        ),
      ),
    );
    return flush
      ..show(context).then((value) {
        if (popAfter) {
          context.pop();
        }
        return value;
      });
  }
}
