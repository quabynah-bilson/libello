import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/injector.dart';
import 'package:libello/features/shared/domain/entities/folder.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
import 'package:libello/features/shared/domain/repositories/notes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteRepository implements BaseNoteRepository {
  // final _prefs = ;
  static final _kNoteRef =
      getIt.get<FirebaseFirestore>().collection('libello-notes');
  static final _kNoteFolderRef =
      getIt.get<FirebaseFirestore>().collection('libello-note-folders');

  @override
  Future<Either<NoteFolder, String>> createFolder(NoteFolder folder) async {
    // TODO: implement createFolder
    throw UnimplementedError();
  }

  @override
  Future<Either<Note, String>> createNote(Note note) async {
    try {
      /// update owner details
      note = note.copyWith(
          owner: (await getIt.getAsync<SharedPreferences>())
              .getString(kUserIdKey));
      await _kNoteRef.doc(note.id).set(note.toJson());
      return Left(note);
    } catch (e) {
      logger.e(e);
    }
    return const Right('An error occurred while creating the note');
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
  Future<Either<Stream<List<NoteFolder>>, String>> getFolders() async {
    var owner =
        (await getIt.getAsync<SharedPreferences>()).getString(kUserIdKey);
    if (owner == null) return const Right(kAuthRequired);
    try {
      var stream = _kNoteFolderRef.snapshots(includeMetadataChanges: true).map(
          (event) =>
              event.docs.map((e) => NoteFolder.fromJson(e.data())).toList());
      return Left(stream);
    } catch (e) {
      logger.e(e);
    }
    return const Right('An error occurred while getting your folders');
  }

  @override
  Future<Either<Stream<Note>, String>> getNote(String id) async {
    try {
      var stream = _kNoteRef
          .doc(id)
          .snapshots(includeMetadataChanges: true)
          .map((event) => Note.fromJson(event.data()));
      return Left(stream);
    } catch (e) {
      logger.e(e);
    }
    return const Right('An error occurred while getting this note');
  }

  @override
  Future<Either<Stream<List<Note>>, String>> getNotes({
    NoteStatus status = NoteStatus.regular,
    NoteType type = NoteType.important,
  }) async {
    await Future.delayed(kListAnimationDuration);
    var owner =
        (await getIt.getAsync<SharedPreferences>()).getString(kUserIdKey);
    if (owner == null) return const Right(kAuthRequired);
    try {
      var stream = _kNoteRef.snapshots(includeMetadataChanges: true).map(
          (event) => event.docs.map((e) => Note.fromJson(e.data())).toList());
      return Left(stream);
    } catch (e) {
      logger.e(e);
    }
    return const Right('An error occurred while getting your notes');
  }

  @override
  Future<Either<NoteFolder, String>> updateFolder(NoteFolder folder) async {
    // TODO: implement updateFolder
    throw UnimplementedError();
  }

  @override
  Future<Either<Note, String>> updateNote(Note note) async {
    try {
      await _kNoteRef.doc(note.id).set(note.toJson(), SetOptions(merge: true));
      return Left(note);
    } catch (e) {
      logger.e(e);
    }
    return const Right('An error occurred while creating the note');
  }
}
