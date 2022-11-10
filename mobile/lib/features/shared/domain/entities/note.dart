import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

enum NoteStatus {
  regular,
  archived,
  deleted,
}

enum NoteType {
  important,
  todoList,
  business,
}

@JsonSerializable()
@CopyWith()
class Note {
  final String id;
  final String title;
  final DateTime updatedAt;
  final NoteType type;
  final NoteStatus status;
  final String? folder;
  final String owner;
  final bool completed;

  const Note({
    required this.id,
    required this.title,
    required this.updatedAt,
    this.type = NoteType.important,
    this.status = NoteStatus.regular,
    this.folder,
    this.owner = '', // add this when uploading to server
    this.completed = false,
  });

  factory Note.fromJson(json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);

  @override
  String toString() => toJson().toString();
}
