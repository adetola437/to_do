import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do/core/data/model/note.dart';
import 'package:to_do/features/home/repository/repository.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  HomeRepository repository;
  NoteCubit({required this.repository}) : super(NoteInitial());

  createNote(Note note)async{
    try {
        emit(NoteCreateLoading());
   await repository.saveNote(note);
   emit(NoteCreateSuccess());
   loadNotes();

    } catch (e) {
      emit(NoteCreateError());
    }
  
  }

  deleteNote(String noteId)async{
    try {
        emit(NoteCreateLoading());
   await repository.deleteNote(noteId);
   emit(NoteCreateSuccess());
   loadNotes();

    } catch (e) {
      emit(NoteCreateError());}
  }


  Future<void> loadNotes({String? query, String? category, DateTime? date}) async {
  try {
    emit(FetchingNotes());
    
  
    List<Note> notes = await repository.loadNotes();
    

    if (category != null && category != 'All') {
      notes = notes.where((note) => note.category == category).toList();
    }
    
    if (query != null && query.isNotEmpty) {
      notes = notes.where((note) {
        final titleMatch = note.title!.toLowerCase().contains(query.toLowerCase());
        final contentMatch = _getPlainTextFromQuill(note.quillContent ?? '')
            .toLowerCase()
            .contains(query.toLowerCase());
        return titleMatch || contentMatch;
      }).toList();
    }
    
    if (date != null) {
      notes = notes.where((note) {
        return note.createdAt?.year == date.year &&
               note.createdAt?.month == date.month &&
               note.createdAt?.day == date.day;
      }).toList();
    }
    
 
    notes.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
    
    emit(NotesLoaded(notes));
  } catch (e) {
    emit(NoteError('Failed to load notes: ${e.toString()}'));
  }
}

String _getPlainTextFromQuill(String quillJson) {
  try {
    final doc = quill.Document.fromJson(jsonDecode(quillJson));
    return doc.toPlainText();
  } catch (e) {
    return '';
  }
}

  filterNotes({String? category, String? searchQuery})async{
    try {

    } catch (e) {
      
    }
  }
}
