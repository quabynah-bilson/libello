import 'package:bloc/bloc.dart';
import 'package:libello/core/injector.dart';
import 'package:libello/features/shared/domain/entities/folder.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
import 'package:libello/features/shared/domain/repositories/notes.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final _repo = getIt.get<BaseNoteRepository>();

  NoteCubit() : super(NoteInitial());

  Future<void> createNote(Note note) async {
    emit(NoteLoading());
    var either = await _repo.createNote(note);
    either.fold(
      (l) => emit(NoteSuccess(l)),
      (r) => emit(NoteError(r)),
    );
  }

  Future<void> getNotes({
    NoteStatus status = NoteStatus.regular,
    NoteType type = NoteType.important,
  }) async {
    emit(NoteLoading());
    var either = await _repo.getNotes();
    either.fold(
      (l) => l.listen((event) => emit(NoteSuccess<List<Note>>(event))),
      (r) => emit(NoteError(r)),
    );
  }

  Future<void> getNoteFolders() async {
    emit(NoteLoading());
    var either = await _repo.getFolders();
    either.fold(
      (l) => l.listen((event) => emit(NoteSuccess<List<NoteFolder>>(event))),
      (r) => emit(NoteError(r)),
    );
  }

  Future<void> updateNote(Note note) async {
    emit(NoteLoading());
    var either = await _repo.updateNote(note);
    either.fold(
      (l) => emit(NoteSuccess(l)),
      (r) => emit(NoteError(r)),
    );
  }

  Future<void> getNote(String id) async {
    emit(NoteLoading());
    var either = await _repo.getNote(id);
    either.fold(
      (l) => l.listen((event) => event == null
          ? emit(const NoteError('Note deleted from your library'))
          : emit(NoteSuccess<Note>(event))),
      (r) => emit(NoteError(r)),
    );
  }

  Future<void> deleteNote(String id) async {
    emit(NoteLoading());
    var either = await _repo.deleteNote(id);
    either.fold(
      (l) => emit(NoteSuccess(l)),
      (r) => emit(NoteError(r)),
    );
  }

  Future<void> createFolder(NoteFolder folder) async {
    emit(NoteLoading());
    var either = await _repo.createFolder(folder);
    either.fold(
      (l) => emit(NoteSuccess(l)),
      (r) => emit(NoteError(r)),
    );
  }
}
