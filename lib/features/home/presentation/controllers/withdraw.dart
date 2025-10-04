import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


import '../../../../config/di/app_initializer.dart';
import '../../../../core/utils/toast.dart';
import '/core/navigation/navigator.dart';
import '/core/theme/theme.dart';
import '/core/utils/contracts.dart';
import '/core/utils/extensions.dart';
import '/core/utils/utils.dart';



part '../contracts/withdraw.dart';
part '../views/withdraw.dart';

class WithdrawScreen extends StatefulWidget {
  static const route = '/withdraw';
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen>
    implements WithdrawControllerContract {
  late final WithdrawViewContract view;

  @override
  void initState() {
    super.initState();

    view = WithdrawView(
      controller: this,
    );
  }



  @override
  Widget build(BuildContext context) {
    return view.build(context);
  }
}
