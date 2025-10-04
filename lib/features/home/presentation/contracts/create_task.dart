part of '../controllers/create_task.dart';

abstract class CreateTaskControllerContract {
  // void forgotPassword();
   QuillController? controller;
   Note? note;
   bool? isEdit;
}

abstract class CreateTaskViewContract extends BaseViewContract {}
