// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NoteCWProxy {
  Note body(String body);

  Note color(NoteRgbColor? color);

  Note folder(String? folder);

  Note id(String id);

  Note lockPin(int? lockPin);

  Note owner(String owner);

  Note status(NoteStatus status);

  Note tags(List<String> tags);

  Note title(String title);

  Note todos(List<NoteTodo> todos);

  Note type(NoteType type);

  Note updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Note(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Note(...).copyWith(id: 12, name: "My name")
  /// ````
  Note call({
    String? body,
    NoteRgbColor? color,
    String? folder,
    String? id,
    int? lockPin,
    String? owner,
    NoteStatus? status,
    List<String>? tags,
    String? title,
    List<NoteTodo>? todos,
    NoteType? type,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNote.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNote.copyWith.fieldName(...)`
class _$NoteCWProxyImpl implements _$NoteCWProxy {
  final Note _value;

  const _$NoteCWProxyImpl(this._value);

  @override
  Note body(String body) => this(body: body);

  @override
  Note color(NoteRgbColor? color) => this(color: color);

  @override
  Note folder(String? folder) => this(folder: folder);

  @override
  Note id(String id) => this(id: id);

  @override
  Note lockPin(int? lockPin) => this(lockPin: lockPin);

  @override
  Note owner(String owner) => this(owner: owner);

  @override
  Note status(NoteStatus status) => this(status: status);

  @override
  Note tags(List<String> tags) => this(tags: tags);

  @override
  Note title(String title) => this(title: title);

  @override
  Note todos(List<NoteTodo> todos) => this(todos: todos);

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
    Object? body = const $CopyWithPlaceholder(),
    Object? color = const $CopyWithPlaceholder(),
    Object? folder = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? lockPin = const $CopyWithPlaceholder(),
    Object? owner = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? tags = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? todos = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Note(
      body: body == const $CopyWithPlaceholder() || body == null
          ? _value.body
          // ignore: cast_nullable_to_non_nullable
          : body as String,
      color: color == const $CopyWithPlaceholder()
          ? _value.color
          // ignore: cast_nullable_to_non_nullable
          : color as NoteRgbColor?,
      folder: folder == const $CopyWithPlaceholder()
          ? _value.folder
          // ignore: cast_nullable_to_non_nullable
          : folder as String?,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      lockPin: lockPin == const $CopyWithPlaceholder()
          ? _value.lockPin
          // ignore: cast_nullable_to_non_nullable
          : lockPin as int?,
      owner: owner == const $CopyWithPlaceholder() || owner == null
          ? _value.owner
          // ignore: cast_nullable_to_non_nullable
          : owner as String,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as NoteStatus,
      tags: tags == const $CopyWithPlaceholder() || tags == null
          ? _value.tags
          // ignore: cast_nullable_to_non_nullable
          : tags as List<String>,
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      todos: todos == const $CopyWithPlaceholder() || todos == null
          ? _value.todos
          // ignore: cast_nullable_to_non_nullable
          : todos as List<NoteTodo>,
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

abstract class _$NoteTodoCWProxy {
  NoteTodo completed(bool completed);

  NoteTodo text(String text);

  NoteTodo updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NoteTodo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NoteTodo(...).copyWith(id: 12, name: "My name")
  /// ````
  NoteTodo call({
    bool? completed,
    String? text,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNoteTodo.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNoteTodo.copyWith.fieldName(...)`
class _$NoteTodoCWProxyImpl implements _$NoteTodoCWProxy {
  final NoteTodo _value;

  const _$NoteTodoCWProxyImpl(this._value);

  @override
  NoteTodo completed(bool completed) => this(completed: completed);

  @override
  NoteTodo text(String text) => this(text: text);

  @override
  NoteTodo updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NoteTodo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NoteTodo(...).copyWith(id: 12, name: "My name")
  /// ````
  NoteTodo call({
    Object? completed = const $CopyWithPlaceholder(),
    Object? text = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return NoteTodo(
      completed: completed == const $CopyWithPlaceholder() || completed == null
          ? _value.completed
          // ignore: cast_nullable_to_non_nullable
          : completed as bool,
      text: text == const $CopyWithPlaceholder() || text == null
          ? _value.text
          // ignore: cast_nullable_to_non_nullable
          : text as String,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $NoteTodoCopyWith on NoteTodo {
  /// Returns a callable class that can be used as follows: `instanceOfNoteTodo.copyWith(...)` or like so:`instanceOfNoteTodo.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NoteTodoCWProxy get copyWith => _$NoteTodoCWProxyImpl(this);
}

abstract class _$NoteRgbColorCWProxy {
  NoteRgbColor blue(int blue);

  NoteRgbColor green(int green);

  NoteRgbColor opacity(double opacity);

  NoteRgbColor red(int red);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NoteRgbColor(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NoteRgbColor(...).copyWith(id: 12, name: "My name")
  /// ````
  NoteRgbColor call({
    int? blue,
    int? green,
    double? opacity,
    int? red,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNoteRgbColor.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNoteRgbColor.copyWith.fieldName(...)`
class _$NoteRgbColorCWProxyImpl implements _$NoteRgbColorCWProxy {
  final NoteRgbColor _value;

  const _$NoteRgbColorCWProxyImpl(this._value);

  @override
  NoteRgbColor blue(int blue) => this(blue: blue);

  @override
  NoteRgbColor green(int green) => this(green: green);

  @override
  NoteRgbColor opacity(double opacity) => this(opacity: opacity);

  @override
  NoteRgbColor red(int red) => this(red: red);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NoteRgbColor(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NoteRgbColor(...).copyWith(id: 12, name: "My name")
  /// ````
  NoteRgbColor call({
    Object? blue = const $CopyWithPlaceholder(),
    Object? green = const $CopyWithPlaceholder(),
    Object? opacity = const $CopyWithPlaceholder(),
    Object? red = const $CopyWithPlaceholder(),
  }) {
    return NoteRgbColor(
      blue: blue == const $CopyWithPlaceholder() || blue == null
          ? _value.blue
          // ignore: cast_nullable_to_non_nullable
          : blue as int,
      green: green == const $CopyWithPlaceholder() || green == null
          ? _value.green
          // ignore: cast_nullable_to_non_nullable
          : green as int,
      opacity: opacity == const $CopyWithPlaceholder() || opacity == null
          ? _value.opacity
          // ignore: cast_nullable_to_non_nullable
          : opacity as double,
      red: red == const $CopyWithPlaceholder() || red == null
          ? _value.red
          // ignore: cast_nullable_to_non_nullable
          : red as int,
    );
  }
}

extension $NoteRgbColorCopyWith on NoteRgbColor {
  /// Returns a callable class that can be used as follows: `instanceOfNoteRgbColor.copyWith(...)` or like so:`instanceOfNoteRgbColor.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NoteRgbColorCWProxy get copyWith => _$NoteRgbColorCWProxyImpl(this);
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
      lockPin: json['lockPin'] as int?,
      color: const NoteRgbColorSerializer()
          .fromJson(json['color'] as Map<String, dynamic>?),
      body: json['body'] as String? ?? '',
      owner: json['owner'] as String? ?? '',
      todos: (json['todos'] as List<dynamic>?)
              ?.map((e) => const NoteTodoSerializer()
                  .fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <NoteTodo>[],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
    );

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'type': _$NoteTypeEnumMap[instance.type]!,
      'status': _$NoteStatusEnumMap[instance.status]!,
      'folder': instance.folder,
      'lockPin': instance.lockPin,
      'owner': instance.owner,
      'tags': instance.tags,
      'todos': instance.todos.map(const NoteTodoSerializer().toJson).toList(),
      'color': const NoteRgbColorSerializer().toJson(instance.color),
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
  NoteStatus.secret: 'secret',
};

NoteTodo _$NoteTodoFromJson(Map<String, dynamic> json) => NoteTodo(
      text: json['text'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      completed: json['completed'] as bool? ?? false,
    );

Map<String, dynamic> _$NoteTodoToJson(NoteTodo instance) => <String, dynamic>{
      'text': instance.text,
      'completed': instance.completed,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

NoteRgbColor _$NoteRgbColorFromJson(Map<String, dynamic> json) => NoteRgbColor(
      red: json['red'] as int,
      green: json['green'] as int,
      blue: json['blue'] as int,
      opacity: (json['opacity'] as num).toDouble(),
    );

Map<String, dynamic> _$NoteRgbColorToJson(NoteRgbColor instance) =>
    <String, dynamic>{
      'red': instance.red,
      'green': instance.green,
      'blue': instance.blue,
      'opacity': instance.opacity,
    };
