// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
      id: json['id'] as String,
      title: json['title'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      type: $enumDecodeNullable(_$NoteTypeEnumMap, json['type']) ??
          NoteType.important,
      status: $enumDecodeNullable(_$NoteStatusEnumMap, json['status']) ??
          NoteStatus.regular,
      folder: json['folder'] as String?,
    );

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'type': _$NoteTypeEnumMap[instance.type]!,
      'status': _$NoteStatusEnumMap[instance.status]!,
      'folder': instance.folder,
    };

const _$NoteTypeEnumMap = {
  NoteType.important: 'important',
  NoteType.todoList: 'todoList',
  NoteType.business: 'business',
};

const _$NoteStatusEnumMap = {
  NoteStatus.regular: 'regular',
  NoteStatus.archived: 'archived',
  NoteStatus.deleted: 'deleted',
};
