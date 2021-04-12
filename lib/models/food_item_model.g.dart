// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FoodItem _$_$_FoodItemFromJson(Map<String, dynamic> json) {
  return _$_FoodItem(
    id: json['id'] as String?,
    foodName: json['foodName'] as String,
    imageUrl: json['imageUrl'] as String? ?? 'https://i.imgur.com/QKYJihU.png',
  );
}

Map<String, dynamic> _$_$_FoodItemToJson(_$_FoodItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'foodName': instance.foodName,
      'imageUrl': instance.imageUrl,
    };
