import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do/features/home/presentation/controllers/create_task.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;




import '../../../../core/data/model/note.dart';
import '../../../../core/data/model/note_category.dart';
import '../bloc/note/note_cubit.dart';
import '/core/utils/contracts.dart';


part '../contracts/home.dart';
part '../views/home.dart';




class HomeScreen extends StatefulWidget {
  static const route = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    implements HomeControllerContract {
  late final HomeViewContract view;

  @override
  void initState() {
    super.initState();

    view = HomeView(
      controller: this,
    );
    loadNotes();
  }



  @override
  Widget build(BuildContext context) {
    return view.build(context);
  }
  
  @override
  void createTask() {
  context.push(CreateTaskScreen.route);
  }
  @override
    List<Note>? notes = [];

     @override
  String? selectedCategory = 'All';

   @override
  DateTime? selectedDate = DateTime.now();
  
  @override
  TextEditingController? searchController = TextEditingController();
  
  @override
  void onChangedValue(String value) {
    // TODO: implement onChangedValue
  }
   void _loadSampleNotes() {
    // Add sample notes for demonstration
    notes = [
      Note(
        id: '1',
        title: 'To-do list',
        category: 'To-do lists',
        quillContent: jsonEncode([
          {"insert": "1. Reply to emails\n2. Prepare presentation slides\n"}
        ]),
        createdAt: DateTime(2023, 5, 23),
        updatedAt: DateTime(2023, 5, 23),
        color: Colors.lightBlue.shade100,
      ),
      Note(
        id: '2',
        title: 'Homework',
        category: 'Homework',
        quillContent: jsonEncode([
          {"insert": "1. Read chapters 5 for Psychology class\n"}
        ]),
        createdAt: DateTime(2023, 5, 23),
        updatedAt: DateTime(2023, 5, 23),
        color: Colors.pink.shade100,
      ),
    ];
  }

  loadNotes(){
    context.read<NoteCubit>().loadNotes();
  }


@override
 List<NoteCategory>? defaultCategories = [
  NoteCategory(name: 'All', color: Colors.grey),
  NoteCategory(name: 'Important', color: Colors.red),
  NoteCategory(name: 'Lecture notes', color: Colors.blue),
  NoteCategory(name: 'To-do lists', color: Colors.lightBlue),
  NoteCategory(name: 'Shopping', color: Colors.purple),
  NoteCategory(name: 'Homework', color: Colors.pink),
  NoteCategory(name: 'Personal', color: Colors.yellow),
  NoteCategory(name: 'Work', color: Colors.green),
];


@override
 String getPlainTextFromQuill(String quillJson) {
    try {
      final doc = quill.Document.fromJson(jsonDecode(quillJson));
      return doc.toPlainText();
    } catch (e) {
      return '';
    }
  }
  
  @override
  void setCategory(NoteCategory category) {
  setState(() {
    selectedCategory = category.name;
  });
 
  }
  
  @override
  void viewNote(Note note) {
    // TODO: implement viewNote
  }

@override
    List<Note> get filteredNotes {
    var filtered = notes;

    // Filter by category
    if (selectedCategory != 'All') {
      filtered = filtered!.where((n) => n.category == selectedCategory).toList();
    }

    // Filter by search
    if (searchController!.text.isNotEmpty) {
      filtered = filtered!
          .where((n) => n.title
              .toLowerCase()
              .contains(searchController!.text.toLowerCase()))
          .toList();
    }

    return filtered ?? [];
  }
  
  @override
  void setNotes(List<Note> newNotes){
  setState(() {
    notes = newNotes;
  });
  }

}
