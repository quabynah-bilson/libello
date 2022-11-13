// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NoteFolderCWProxy {
  NoteFolder id(String id);

  NoteFolder label(String label);

  NoteFolder owner(String owner);

  NoteFolder type(FolderType type);

  NoteFolder updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NoteFolder(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NoteFolder(...).copyWith(id: 12, name: "My name")
  /// ````
  NoteFolder call({
    String? id,
    String? label,
    String? owner,
    FolderType? type,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNoteFolder.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNoteFolder.copyWith.fieldName(...)`
class _$NoteFolderCWProxyImpl implements _$NoteFolderCWProxy {
  final NoteFolder _value;

  const _$NoteFolderCWProxyImpl(this._value);

  @override
  NoteFolder id(String id) => this(id: id);

  @override
  NoteFolder label(String label) => this(label: label);

  @override
  NoteFolder owner(String owner) => this(owner: owner);

  @override
  NoteFolder type(FolderType type) => this(type: type);

  @override
  NoteFolder updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NoteFolder(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NoteFolder(...).copyWith(id: 12, name: "My name")
  /// ````
  NoteFolder call({
    Object? id = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? owner = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return NoteFolder(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      label: label == const $CopyWithPlaceholder() || label == null
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String,
      owner: owner == const $CopyWithPlaceholder() || owner == null
          ? _value.owner
          // ignore: cast_nullable_to_non_nullable
          : owner as String,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as FolderType,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $NoteFolderCopyWith on NoteFolder {
  /// Returns a callable class that can be used as follows: `instanceOfNoteFolder.copyWith(...)` or like so:`instanceOfNoteFolder.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NoteFolderCWProxy get copyWith => _$NoteFolderCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteFolder _$NoteFolderFromJson(Map<String, dynamic> json) => NoteFolder(
      id: json['id'] as String,
      label: json['label'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      owner: json['owner'] as String? ?? '',
      type: $enumDecodeNullable(_$FolderTypeEnumMap, json['type']) ??
          FolderType.public,
    );

Map<String, dynamic> _$NoteFolderToJson(NoteFolder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'owner': instance.owner,
      'type': _$FolderTypeEnumMap[instance.type]!,
    };

const _$FolderTypeEnumMap = {
  FolderType.public: 'public',
  FolderType.protected: 'protected',
};
