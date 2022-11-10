import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'folder.g.dart';

@JsonSerializable()
@CopyWith()
class NoteFolder {
  final String id;
  final String label;
  final DateTime updatedAt;

  const NoteFolder({
    required this.id,
    required this.label,
    required this.updatedAt,
  });

  factory NoteFolder.fromJson(json) => _$NoteFolderFromJson(json);

  Map<String, dynamic> toJson() => _$NoteFolderToJson(this);

  @override
  String toString() => toJson().toString();
}
