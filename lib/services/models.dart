import 'package:pocketbase/pocketbase.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class Character {
  final String id;
  final String name;
  final String avatar;
  final List<Field> fields;
  late final Uri avatarUrl;

  Character({
    this.id = '',
    this.name = '',
    this.avatar = 'default_avatar.png',
    this.fields = const [],
  });

  /// Creates a new Character instance form the provided RecordModel.
  factory Character.fromRecord(RecordModel record) => Character.fromJson(record.toJson());

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}

@JsonSerializable()
class Field {
  String id = Uuid().v4();
  final String name;
  final String type;
  final String label;
  final String value; // if it is int - parser will throw an exception
  Object? data;

  Field({
    this.id = '',
    this.name = '',
    this.type = 'text',
    this.label = '',
    this.value = '',
    this.data = const Object(),
  });

  factory Field.fromJson(Map<String, dynamic> json) =>
      _$FieldFromJson(json);
  Map<String, dynamic> toJson() => _$FieldToJson(this);
}
