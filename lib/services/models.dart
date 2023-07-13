import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  getFieldsWidgets() => fields.map((field) => field.getWidget()).toList();

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

  getWidget() {

    Widget widget;

    switch (type) {

      case 'counterIcon':
        
        var iconsWidgets = value.runes.map((c) {
          var sign = String.fromCharCode(c);
          print(sign);
          if (sign == '+') {
            return const Icon(
              FontAwesomeIcons.circle,
              color: Colors.red,
              size: 20,
            );
          }
          else {
            return const Icon(
              FontAwesomeIcons.circle,
              color: Colors.white,
              size: 20,
            );
          }
        }).toList();


        widget = Column(
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                ...iconsWidgets
              ],
            )
          ],
        );

      case 'text':
      default:
        // widget = Text(value);
        // Text field with title
        widget = Column(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        );

    }

    return widget;
  }
}
