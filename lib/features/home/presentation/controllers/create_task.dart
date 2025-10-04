
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:to_do/core/utils/function.dart';
import 'package:to_do/features/home/presentation/bloc/note/note_cubit.dart';



import '../../../../core/data/model/note.dart';
import '../../../../core/utils/contracts.dart';
import '../bloc/category/category_cubit.dart';

part '../contracts/create_task.dart';
part '../views/create_task.dart';

class CreateTaskScreen extends StatefulWidget {
  static const route = '/createTask';
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen>
    implements CreateTaskControllerContract {
  late final CreateTaskViewContract view;

  @override
  void initState() {
    super.initState();
     controller!.readOnly = false;
    view = CreateTaskView(
      controller: this,
    );
   

  }


  // @override
  // void forgotPassword() {
  //   context.navigator.pushNamed(ForgotPasswordScreen.route);
  // }

  @override
  Widget build(BuildContext context) {
    return view.build(context);
  }
    @override
void dispose() {
  controller!.dispose();
  super.dispose();
}

@override
  QuillController? controller = QuillController.basic(
    
  );
}
