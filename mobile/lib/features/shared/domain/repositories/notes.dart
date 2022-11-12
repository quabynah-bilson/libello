import 'package:dartz/dartz.dart';
import 'package:libello/features/shared/domain/entities/folder.dart';
import 'package:libello/features/shared/domain/entities/note.dart';

abstract class BaseNoteRepository {
  /// region notes
  Future<Either<Note, String>> createNote(Note note);

  Future<Either<Note, String>> updateNote(Note note);

  Future<Either<String, String>> deleteNote(String id);

  Future<Either<Stream<Note?>, String>> getNote(String id);

  Future<Either<Stream<List<Note>>, String>> getNotes(
      {NoteStatus status, NoteType type});

  /// endregion notes

  /// region folders
  Future<Either<NoteFolder, String>> createFolder(NoteFolder folder);

  Future<Either<NoteFolder, String>> updateFolder(NoteFolder folder);

  Future<Either<String, String>> deleteFolder(String id);

  Future<Either<Stream<List<NoteFolder>>, String>> getFolders();

  Future<Either<NoteFolder, String>> getFolder(String id);

  /// endregion folders
}
