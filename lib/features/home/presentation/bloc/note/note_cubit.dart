import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do/core/data/model/note.dart';
import 'package:to_do/features/home/repository/repository.dart';

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
      
    }
  
  }

  loadNotes()async{
    try {
      emit(FetchingNotes());
   emit(NotesLoaded(await repository.loadNotes()));
    } catch (e) {
      
    }
  }

  filterNotes({String? category, String? searchQuery})async{
    try {

    } catch (e) {
      
    }
  }
}
