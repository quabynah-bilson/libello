// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NoteCWProxy {
  Note completed(bool completed);

  Note folder(String? folder);

  Note id(String id);

  Note owner(String owner);

  Note status(NoteStatus status);

  Note title(String title);

  Note type(NoteType type);

  Note updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Note(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Note(...).copyWith(id: 12, name: "My name")
  /// ````
  Note call({
    bool? completed,
    String? folder,
    String? id,
    String? owner,
    NoteStatus? status,
    String? title,
    NoteType? type,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNote.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNote.copyWith.fieldName(...)`
class _$NoteCWProxyImpl implements _$NoteCWProxy {
  final Note _value;

  const _$NoteCWProxyImpl(this._value);

  @override
  Note completed(bool completed) => this(completed: completed);

  @override
  Note folder(String? folder) => this(folder: folder);

  @override
  Note id(String id) => this(id: id);

  @override
  Note owner(String owner) => this(owner: owner);

  @override
  Note status(NoteStatus status) => this(status: status);

  @override
  Note title(String title) => this(title: title);

  @override
  Note type(NoteType type) => this(type: type);

  @override
  Note updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Note(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Note(...).copyWith(id: 12, name: "My name")
  /// ````
  Note call({
    Object? completed = const $CopyWithPlaceholder(),
    Object? folder = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? owner = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Note(
      completed: completed == const $CopyWithPlaceholder() || completed == null
          ? _value.completed
          // ignore: cast_nullable_to_non_nullable
          : completed as bool,
      folder: folder == const $CopyWithPlaceholder()
          ? _value.folder
          // ignore: cast_nullable_to_non_nullable
          : folder as String?,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      owner: owner == const $CopyWithPlaceholder() || owner == null
          ? _value.owner
          // ignore: cast_nullable_to_non_nullable
          : owner as String,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as NoteStatus,
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as NoteType,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $NoteCopyWith on Note {
  /// Returns a callable class that can be used as follows: `instanceOfNote.copyWith(...)` or like so:`instanceOfNote.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NoteCWProxy get copyWith => _$NoteCWProxyImpl(this);
}

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
      owner: json['owner'] as String? ?? '',
      completed: json['completed'] as bool? ?? false,
    );

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'type': _$NoteTypeEnumMap[instance.type]!,
      'status': _$NoteStatusEnumMap[instance.status]!,
      'folder': instance.folder,
      'owner': instance.owner,
      'completed': instance.completed,
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
