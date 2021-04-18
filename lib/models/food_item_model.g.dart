// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FoodItem _$_$_FoodItemFromJson(Map<String, dynamic> json) {
  return _$_FoodItem(
    id: json['id'] as String?,
    body: json['body'] as String?,
    lastMade: json['lastMade'] == null
        ? null
        : DateTime.parse(json['lastMade'] as String),
    foodName: json['foodName'] as String,
    imageUrl: json['imageUrl'] as String? ?? 'https://i.imgur.com/QKYJihU.png',
    frequency: json['frequency'] as String? ?? 'Normal',
  );
}

Map<String, dynamic> _$_$_FoodItemToJson(_$_FoodItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'body': instance.body,
      'lastMade': instance.lastMade?.toIso8601String(),
      'foodName': instance.foodName,
      'imageUrl': instance.imageUrl,
      'frequency': instance.frequency,
    };
