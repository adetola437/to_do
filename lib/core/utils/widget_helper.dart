// import 'package:another_flushbar/flushbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_project_template/core/utils/extensions.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';

// abstract class IWidgetHelper {
//   Future showSuccessDialog(String message, BuildContext context,
//       {bool popAfter = false,
//       String title = 'success',
//       String label = 'close'});
//   Future showErrorDialog(String message, BuildContext context,
//       {bool popAfter = false,
//       String title = 'an_error_occured',
//       String label = 'close'});
// }

// class WidgetHelper implements IWidgetHelper {
//   @override
//   Future showErrorDialog(String message, BuildContext context,
//       {bool popAfter = false,
//       String title = 'an_error_occured',
//       String label = 'close'}) async {
//     late Flushbar flush;
//     flush = Flushbar(
//       margin: EdgeInsets.symmetric(horizontal: 16.r),
//       padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 16.sp),
//       borderRadius: BorderRadius.circular(16.r),
//       // icon: Image.asset('assets/images/launcher_icon.png'),
//       title: 'An error occured',
//       titleSize: 16.sp,
//       messageSize: 14.sp,
//       backgroundColor: Colors.red.withOpacity(0.85),
//       flushbarPosition: FlushbarPosition.TOP,
//       mainButton: TextButton(
//         onPressed: () {
//           flush.dismiss(popAfter);
//         },
//         child: 'close'.toText(),
//       ),
//       flushbarStyle: FlushbarStyle.FLOATING,
//       message: message,
//       // isDismissible: false,
//       blockBackgroundInteraction: true,
//       // duration: popAfter ? Duration(seconds: 3) : null,
//     );
//     return flush
//       ..show(context).then((value) {
//         if (popAfter) {
//           context.pop();
//         }
//       });
//   }

//   @override
//   Future showSuccessDialog(String message, BuildContext context,
//       {bool popAfter = false,
//       String title = 'Success',
//       String label = 'close'}) async {
//     late Flushbar flush;
//     flush = Flushbar(
//       margin: REdgeInsets.symmetric(horizontal: 18.r),
//       borderRadius: BorderRadius.circular(16.r),
//       // borderColor: context.customColors.green!,
//       icon: SvgPicture.asset(
//         'assets/vectors/success_icon.svg',
//         fit: BoxFit.scaleDown,
//       ),
//       // title: title, titleSize: 16.sp,
//       messageSize: 14.sp,
//       backgroundColor: Colors.green,
//       flushbarPosition: FlushbarPosition.TOP,
//       flushbarStyle: FlushbarStyle.FLOATING,
//       message: message,
//       duration: popAfter ? const Duration(seconds: 3) : null,
//       mainButton: TextButton(
//         onPressed: () {
//           flush.dismiss(popAfter);
//         },
//         child: 'close'.toText(),
//       ),
//     );
//     return flush
//       ..show(context).then((value) {
//         if (popAfter) {
//           context.pop();
//         }
//         return value;
//       });
//   }
// }
