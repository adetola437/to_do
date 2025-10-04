part of '../controllers/view_note.dart';

abstract class ViewNoteControllerContract {
 Note? note;
    QuillController? controller;

  void edit() {}
}

abstract class ViewNoteViewContract extends BaseViewContract {

}
