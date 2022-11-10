// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteFolder _$NoteFolderFromJson(Map<String, dynamic> json) => NoteFolder(
      id: json['id'] as String,
      label: json['label'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$NoteFolderToJson(NoteFolder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
