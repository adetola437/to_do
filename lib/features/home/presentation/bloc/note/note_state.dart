part of 'note_cubit.dart';

sealed class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

final class NoteInitial extends NoteState {}

final class NoteCreateLoading extends NoteState {}

final class FetchingNotes extends NoteState {}

final class NotesLoaded extends NoteState{
  final List<Note> notes;

  const NotesLoaded(this.notes);

  @override
  List<Object> get props => [notes];

}
final class NoteCreateSuccess extends NoteState {}

final class NoteCreateError extends NoteState {}

final class NoteError extends NoteState {
  final String message;

  const NoteError(this.message);

  @override
  List<Object> get props => [message];
}

final class NoteDeleteSuccess extends NoteState {}final class NoteDeleteError extends NoteState {}




