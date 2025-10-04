part of '../controllers/home.dart';

abstract class HomeControllerContract {
  void createTask() {}
  TextEditingController? searchController;

  void onChangedValue(String value) {}
    List<Note>? notes;
  String? selectedCategory;
  DateTime? selectedDate;

   List<NoteCategory>? defaultCategories;
   String getPlainTextFromQuill(String quillJson);

  void viewNote(Note note) {}

  void setCategory(NoteCategory category) {}
  List<Note> get filteredNotes;

  void setNotes(List<Note> notes);


}

abstract class HomeViewContract extends BaseViewContract {}
