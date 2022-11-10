import 'package:dartz/dartz.dart';
import 'package:libello/features/shared/domain/entities/folder.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
import 'package:libello/features/shared/domain/repositories/notes.dart';

class NoteRepository implements BaseNoteRepository {
  // final _prefs = ;
  static const _kNoteRef = 'libello-notes';
  static const _kNoteFolderRef = 'libello-note-folders';

  @override
  Future<Either<NoteFolder, String>> createFolder(NoteFolder folder) async {
    // TODO: implement createFolder
    throw UnimplementedError();
  }

  @override
  Future<Either<Note, String>> createNote(Note note) {
    // TODO: implement createNote
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> deleteFolder(String id) {
    // TODO: implement deleteFolder
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> deleteNote(Note note) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<Either<NoteFolder, String>> getFolder(String id) {
    // TODO: implement getFolder
    throw UnimplementedError();
  }

  @override
  Future<Either<List<NoteFolder>, String>> getFolders() {
    // TODO: implement getFolders
    throw UnimplementedError();
  }

  @override
  Future<Either<Note, String>> getNote(String id) {
    // TODO: implement getNote
    throw UnimplementedError();
  }

  @override
  Future<Either<List<Note>, String>> getNotes({
    NoteStatus status = NoteStatus.regular,
    NoteType type = NoteType.important,
  }) async {
    // TODO: implement getNotes
    throw UnimplementedError();
  }

  @override
  Future<Either<NoteFolder, String>> updateFolder(NoteFolder folder) async {
    // TODO: implement updateFolder
    throw UnimplementedError();
  }

  @override
  Future<Either<Note, String>> updateNote(Note note) async {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}
