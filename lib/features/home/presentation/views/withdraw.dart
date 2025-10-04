part of '../controllers/withdraw.dart';

class WithdrawView extends StatelessWidget implements WithdrawViewContract {
  const WithdrawView({super.key, required this.controller});

  final WithdrawControllerContract controller;

  @override
  Widget build(BuildContext context) {
    final widgetHelper = AppInitializer.instanceLocator.get<IWidgetHelper>();

    return Scaffold();
  }

}
