


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do/core/utils/extensions.dart';
import 'package:to_do/features/home/presentation/bloc/note/note_cubit.dart';




import '../../../../core/data/model/note.dart';
import '/core/utils/contracts.dart';
import 'create_task.dart';




part '../contracts/view_note.dart';
part '../views/view_note.dart';

class ViewNoteScreen extends StatefulWidget {
  static const route = '/ViewNote';
  const ViewNoteScreen({super.key, required this.note});

  final Note note;

  @override
  State<ViewNoteScreen> createState() => _ViewNoteScreenState();
}

class _ViewNoteScreenState extends State<ViewNoteScreen>
    implements ViewNoteControllerContract {
  late final ViewNoteViewContract view;

  @override
  void initState() {
    super.initState();

    view = ViewNoteView(
      controller: this,
    );
    note = widget.note;
    controller!.readOnly = true;
    controller!.document = Document.fromJson(jsonDecode(note!.quillContent ?? ''));
  }



  @override
  Widget build(BuildContext context) {
    return view.build(context);
  }

  @override
  Note? note;

  @override
  QuillController? controller = QuillController.basic();
  
  @override
  void edit() {
  context.pop();
  context.push(CreateTaskScreen.route, extra: note);
  }
}
