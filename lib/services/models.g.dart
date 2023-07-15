// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      avatar: json['avatar'] as String? ?? 'default_avatar.png',
      fields: (json['fields'] as List<dynamic>?)
              ?.map((e) => Field.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      avatarUrl: json['avatarUrl'] ?? '',
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'fields': instance.fields,
      'avatarUrl': instance.avatarUrl,
    };

Field _$FieldFromJson(Map<String, dynamic> json) => Field(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? 'text',
      label: json['label'] as String? ?? '',
      group: json['group'] as String? ?? '',
      value: json['value'] as String? ?? '',
      data: json['data'] ?? const Object(),
    );

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'label': instance.label,
      'group': instance.group,
      'value': instance.value,
      'data': instance.data,
    };

CharacterSheet _$CharacterSheetFromJson(Map<String, dynamic> json) =>
    CharacterSheet(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      image: json['image'] as String? ?? '',
      creator: json['creator'] as String? ?? '',
      template: (json['template'] as List<dynamic>?)
              ?.map(
                  (e) => CSTemplateElement.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      rpgSystem: json['rpgSystem'] as String? ?? '',
    );

Map<String, dynamic> _$CharacterSheetToJson(CharacterSheet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'creator': instance.creator,
      'template': instance.template,
      'rpgSystem': instance.rpgSystem,
    };

CSTemplateElement _$CSTemplateElementFromJson(Map<String, dynamic> json) =>
    CSTemplateElement(
      type: json['type'] as String? ?? '',
      label: json['label'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      rendersGroups: (json['rendersGroups'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      content: (json['content'] as List<dynamic>?)
              ?.map(
                  (e) => CSTemplateElement.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CSTemplateElementToJson(CSTemplateElement instance) =>
    <String, dynamic>{
      'type': instance.type,
      'label': instance.label,
      'icon': instance.icon,
      'rendersGroups': instance.rendersGroups,
      'content': instance.content,
    };
