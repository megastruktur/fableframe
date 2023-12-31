import 'package:fableframe/characters/character_item.dart';
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
  dynamic avatarUrl;

  Character({
    this.id = '',
    this.name = '',
    this.avatar = 'default_avatar.png',
    this.fields = const [],
    this.avatarUrl = '',
  });

  /// Creates a new Character instance form the provided RecordModel.
  factory Character.fromRecord(RecordModel record) => Character.fromJson(record.toJson());

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  List<Widget> getFieldsWidgets() => fields.map((field) => field.getWidget()).toList();

  Field getFieldByName(String fieldName) => fields.firstWhere((field) => field.name == fieldName);

  getFieldsByGroups(List<String> groupNames) => fields.where((field) =>  groupNames.contains(field.group)).toList();

}

@JsonSerializable()
class Field {
  String id = Uuid().v4(); // for CRUD purposes
  final String name; // Unique (?) name field is for RPG System and CharacterSheet
  final String type; // for Rendering purposes
  final String label; // Editable Label
  final String group; // group to render
  final String value; // if it is int - parser will throw an exception
  Object? data; // For future logic?

  Field({
    this.id = '',
    this.name = '',
    this.type = 'text',
    this.label = '',
    this.group = '',
    this.value = '',
    this.data = const Object(),
  });

  factory Field.fromJson(Map<String, dynamic> json) =>
      _$FieldFromJson(json);
  Map<String, dynamic> toJson() => _$FieldToJson(this);

  Widget getWidget() {

    Widget widget;

    switch (type) {

      case 'counterIcon':
        
        var iconsWidgets = value.runes.map((c) {
          var sign = String.fromCharCode(c);
          if (sign == '+') {
            return const Icon(
              FontAwesomeIcons.solidCircle,
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
            Text(
              value,
            ),
          ],
        );

    }

    return widget;
  }
}


@JsonSerializable()
class CharacterSheet {
  final String id;
  final String name;
  final String? description;
  final String image;
  final String creator;
  final List<CSTemplateElement> template;
  final String rpgSystem;

  CharacterSheet({
    this.id = '',
    this.name = '',
    this.description = '',
    this.image = '',
    this.creator = '',
    this.template = const [],
    this.rpgSystem = '',
  });

  factory CharacterSheet.fromJson(Map<String, dynamic> json) =>
      _$CharacterSheetFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterSheetToJson(this);

  factory CharacterSheet.fromRecord(RecordModel record) => CharacterSheet.fromJson(record.toJson());


  (List<Widget>, List<Widget>) getCharacterTabsAndTabBar(Character character) {
    // Foreach Tab.
    List<Widget> tabs = [];
    List<Widget> tabIcons = [];

    template.forEach((element) {
      
      // Create a tab header.
      tabIcons.add(const Tab(icon: Icon(Icons.directions_car)));

      // Create a tab body.
      List<Widget> tab = [];

      element.content?.forEach((contentElement) {
        try {
          List<Widget>? widgets = contentElement.getWidgets(character);
          // Add all items from widgets List to tab List
          widgets?.forEach((widget) {
            tab.add(widget);
          });
        }
        catch (e, stacktrace) {
          logger.e(e);
          logger.e(stacktrace);
        }
      });
      tabs.add(ListView(
        children: tab,
      ));
    });

    // Add Description Tab
    tabIcons.add(const Tab(icon: Icon(Icons.info)));

    // Adds a Character Description tab
    // @todo move to Template
    var descriptionTab =
      Container(
        height: 140,
        clipBehavior: Clip.antiAlias,
        
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 5,
          ),
          shape: BoxShape.circle,
          color: Colors.deepPurpleAccent,
          image: character.avatar == ""
            ? const DecorationImage(
                image: AssetImage('assets/covers/avatar_placeholder.png'),
                fit: BoxFit.contain,
              )
            : DecorationImage(
                image: NetworkImage(character.avatarUrl.toString()),
                fit: BoxFit.contain,
              ),
        ),
      );

    tabs.add(descriptionTab);

    return (tabIcons, tabs);
  }

  getCharacterSheetView(Character character) {

    var (tabIcons, tabs) = getCharacterTabsAndTabBar(character);

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: tabIcons,
          ),
        ),
        body: TabBarView(
          children: tabs,
        ),
      ),
    );
  }
}


@JsonSerializable()
class CSTemplateElement {
  final String type;
  final String label;
  final String? icon;
  final List<String>? rendersGroups; // render group of fields.
  final String? renderName; // render group of fields.
  final List<CSTemplateElement>? content;

  CSTemplateElement({
    this.type = '',
    this.label = '',
    this.icon = '',
    this.renderName = '',
    this.rendersGroups = const [],
    this.content = const [],
  });

  factory CSTemplateElement.fromJson(Map<String, dynamic> json) =>
      _$CSTemplateElementFromJson(json);
  Map<String, dynamic> toJson() => _$CSTemplateElementToJson(this);

  factory CSTemplateElement.fromRecord(RecordModel record) => CSTemplateElement.fromJson(record.toJson());

  List<Widget>? getWidgets(Character character) {
    // Get Content.
    if (renderName != '') {
        Field field = character.getFieldByName(renderName!);
        return [field.getWidget()];
    } else if (rendersGroups!.isNotEmpty) {
        List<Field> groupFields = character.getFieldsByGroups(rendersGroups!);
        return groupFields.map((f) => f.getWidget()).toList();
    }
    return null;
  }
}
