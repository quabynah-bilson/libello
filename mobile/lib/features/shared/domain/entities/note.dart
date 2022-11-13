import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

enum NoteStatus {
  regular,
  archived,
  deleted,
  secret,
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
  final String body;
  final DateTime updatedAt;
  final NoteType type;
  final NoteStatus status;
  final String? folder;
  final int? lockPin;
  final String owner;
  final List<String> tags;
  @NoteTodoSerializer()
  final List<NoteTodo> todos;
  @NoteRgbColorSerializer()
  final NoteRgbColor? color;

  Note({
    required this.id,
    required this.title,
    required this.updatedAt,
    this.type = NoteType.important,
    this.status = NoteStatus.regular,
    this.folder,
    this.lockPin,
    this.color,
    this.body = '',
    this.owner = '', // add this when uploading to server
    this.todos = const <NoteTodo>[],
    this.tags = const <String>[],
  });

  factory Note.fromJson(json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);

  @override
  String toString() => toJson().toString();
}

@CopyWith()
@JsonSerializable()
class NoteTodo {
  final String text;
  final bool completed;
  final DateTime updatedAt;

  const NoteTodo({
    required this.text,
    required this.updatedAt,
    this.completed = false,
  });

  factory NoteTodo.fromJson(json) => _$NoteTodoFromJson(json);

  Map<String, dynamic> toJson() => _$NoteTodoToJson(this);

  @override
  String toString() => toJson().toString();
}

@CopyWith()
@JsonSerializable()
class NoteRgbColor {
  final int red, green, blue;
  final double opacity;

  NoteRgbColor({
    required this.red,
    required this.green,
    required this.blue,
    required this.opacity,
  });

  factory NoteRgbColor.fromJson(json) => _$NoteRgbColorFromJson(json);

  Map<String, dynamic> toJson() => _$NoteRgbColorToJson(this);

  @override
  String toString() => toJson().toString();
}

class NoteTodoSerializer
    implements JsonConverter<NoteTodo, Map<String, dynamic>> {
  const NoteTodoSerializer();

  @override
  NoteTodo fromJson(Map<String, dynamic> json) => NoteTodo.fromJson(json);

  @override
  Map<String, dynamic> toJson(NoteTodo object) => object.toJson();
}

class NoteRgbColorSerializer
    implements JsonConverter<NoteRgbColor?, Map<String, dynamic>?> {
  const NoteRgbColorSerializer();

  @override
  NoteRgbColor? fromJson(Map<String, dynamic>? json) =>
      json == null ? null : NoteRgbColor.fromJson(json);

  @override
  Map<String, dynamic>? toJson(NoteRgbColor? object) => object?.toJson();
}
