import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/injector.dart';
import 'package:libello/features/shared/domain/entities/folder.dart';
import 'package:libello/features/shared/domain/entities/note.dart';
import 'package:libello/features/shared/domain/repositories/notes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class NoteRepository implements BaseNoteRepository {
  // final _prefs = ;
  static final _kNoteRef =
      getIt.get<FirebaseFirestore>().collection('libello-notes');
  static final _kNoteFolderRef =
      getIt.get<FirebaseFirestore>().collection('libello-note-folders');

  @override
  Future<Either<NoteFolder, String>> createFolder(NoteFolder folder) async {
    try {
      /// update owner details
      folder = folder.copyWith(
          id: const Uuid().v4(),
          owner: (await getIt.getAsync<SharedPreferences>())
              .getString(kUserIdKey));
      await _kNoteFolderRef.doc(folder.id).set(folder.toJson());
      return Left(folder);
    } catch (e) {
      logger.e(e);
    }
    return const Right('An error occurred while creating the note');
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
  Future<Either<String, String>> deleteFolder(String id) async {
    try {
      /// revert all notes with folder
      var snapshot = await _kNoteRef.where('folder', isEqualTo: id).get();
      if (snapshot.size != 0 && snapshot.docs.isNotEmpty) {
        for (var note in snapshot.docs) {
          if (note.exists) {
            var noteFromJson = Note.fromJson(note.data());
            noteFromJson = noteFromJson.copyWith(folder: null);
            await _kNoteRef.doc(note.id).update(noteFromJson.toJson());
          }
        }
      }
      await _kNoteFolderRef.doc(id).delete();
      return const Left('Folder deleted successfully');
    } catch (e) {
      logger.e(e);
    }
    return const Right('An error occurred while deleting the folder');
  }

  @override
  Future<Either<String, String>> deleteNote(String id) async {
    try {
      await _kNoteRef.doc(id).delete();
      return const Left('Note deleted successfully');
    } catch (e) {
      logger.e(e);
    }
    return const Right('An error occurred while deleting the note');
  }

  @override
  Future<Either<Stream<NoteFolder?>, String>> getFolder(String id) async {
    try {
      var stream = _kNoteFolderRef.doc(id).snapshots().map(
          (event) => event.exists ? NoteFolder.fromJson(event.data()) : null);
      return Left(stream);
    } catch (e) {
      logger.e(e);
    }
    return const Right('An error occurred while getting this note');
  }

  @override
  Future<Either<Stream<List<NoteFolder>>, String>> getFolders() async {
    var owner =
        (await getIt.getAsync<SharedPreferences>()).getString(kUserIdKey);
    if (owner == null) return const Right(kAuthRequired);
    try {
      var stream = _kNoteFolderRef
          .orderBy('updatedAt', descending: true)
          .where('owner', isEqualTo: owner)
          .snapshots()
          .map((event) =>
              event.docs.map((e) => NoteFolder.fromJson(e.data())).toList());
      return Left(stream);
    } catch (e) {
      logger.e(e);
    }
    return const Right('An error occurred while getting your folders');
  }

  @override
  Future<Either<Stream<Note?>, String>> getNote(String id) async {
    try {
      var stream = _kNoteRef
          .doc(id)
          .snapshots()
          .map((event) => event.exists ? Note.fromJson(event.data()) : null);
      return Left(stream);
    } catch (e) {
      logger.e(e);
    }
    return const Right('An error occurred while getting this note');
  }

  @override
  Future<Either<Stream<List<Note>>, String>> getNotes({
    NoteStatus? status,
    NoteType? type,
  }) async {
    var owner =
        (await getIt.getAsync<SharedPreferences>()).getString(kUserIdKey);
    if (owner == null) return const Right(kAuthRequired);
    try {
      var stream = _kNoteRef
          .orderBy('updatedAt', descending: true)
          .where('owner', isEqualTo: owner)
          .snapshots()
          .map((event) =>
              event.docs.map((e) => Note.fromJson(e.data())).toList());
      return Left(stream);
    } catch (e) {
      logger.e(e);
    }
    return const Right('An error occurred while getting your notes');
  }

  @override
  Future<Either<NoteFolder, String>> updateFolder(NoteFolder folder) async {
    try {
      await _kNoteFolderRef
          .doc(folder.id)
          .set(folder.toJson(), SetOptions(merge: true));
      return Left(folder);
    } catch (e) {
      logger.e(e);
    }
    return const Right('An error occurred while updating the note');
  }

  @override
  Future<Either<Note, String>> updateNote(Note note) async {
    try {
      await _kNoteRef.doc(note.id).set(note.toJson(), SetOptions(merge: true));
      return Left(note);
    } catch (e) {
      logger.e(e);
    }
    return const Right('An error occurred while updating the note');
  }

  @override
  Future<Either<Stream<List<Note>>, String>> getRecentNotes(
      [int? pageSize]) async {
    var owner =
        (await getIt.getAsync<SharedPreferences>()).getString(kUserIdKey);
    if (owner == null) return const Right(kAuthRequired);
    try {
      var stream = _kNoteRef
          .orderBy('updatedAt', descending: true)
          .where('owner', isEqualTo: owner)
          .limit(pageSize ?? 50)
          .snapshots()
          .map((event) =>
              event.docs.map((e) => Note.fromJson(e.data())).toList());
      return Left(stream);
    } catch (e) {
      logger.e(e);
    }
    return const Right('An error occurred while getting your notes');
  }

  @override
  Future<Either<Stream<List<Note>>, String>> getArchivedNotes() async {
    var owner =
        (await getIt.getAsync<SharedPreferences>()).getString(kUserIdKey);
    if (owner == null) return const Right(kAuthRequired);
    try {
      var stream = _kNoteRef
          .orderBy('updatedAt', descending: true)
          .where('owner', isEqualTo: owner)
          .where('status', isEqualTo: NoteStatus.archived.name)
          .snapshots()
          .map((event) =>
              event.docs.map((e) => Note.fromJson(e.data())).toList());
      return Left(stream);
    } catch (e) {
      logger.e(e);
    }
    return const Right('An error occurred while getting your notes');
  }
}
