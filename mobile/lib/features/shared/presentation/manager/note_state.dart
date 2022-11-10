part of 'note_cubit.dart';

abstract class NoteState {
  const NoteState();
}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteSuccess<T> extends NoteState {
  final T data;

  const NoteSuccess(this.data);
}

class NoteError extends NoteState {
  final String message;

  const NoteError(this.message);
}
