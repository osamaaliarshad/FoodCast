// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'food_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
FoodItem _$FoodItemFromJson(Map<String, dynamic> json) {
  return _FoodItem.fromJson(json);
}

/// @nodoc
class _$FoodItemTearOff {
  const _$FoodItemTearOff();

  _FoodItem call(
      {String? id,
      String? body,
      required String foodName,
      String imageUrl = 'https://i.imgur.com/QKYJihU.png'}) {
    return _FoodItem(
      id: id,
      body: body,
      foodName: foodName,
      imageUrl: imageUrl,
    );
  }

  FoodItem fromJson(Map<String, Object> json) {
    return FoodItem.fromJson(json);
  }
}

/// @nodoc
const $FoodItem = _$FoodItemTearOff();

/// @nodoc
mixin _$FoodItem {
  String? get id;
  String? get body;
  String get foodName;
  String get imageUrl;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $FoodItemCopyWith<FoodItem> get copyWith;
}

/// @nodoc
abstract class $FoodItemCopyWith<$Res> {
  factory $FoodItemCopyWith(FoodItem value, $Res Function(FoodItem) then) =
      _$FoodItemCopyWithImpl<$Res>;
  $Res call({String? id, String? body, String foodName, String imageUrl});
}

/// @nodoc
class _$FoodItemCopyWithImpl<$Res> implements $FoodItemCopyWith<$Res> {
  _$FoodItemCopyWithImpl(this._value, this._then);

  final FoodItem _value;
  // ignore: unused_field
  final $Res Function(FoodItem) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? body = freezed,
    Object? foodName = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String?,
      body: body == freezed ? _value.body : body as String?,
      foodName: foodName == freezed ? _value.foodName : foodName as String,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
    ));
  }
}

/// @nodoc
abstract class _$FoodItemCopyWith<$Res> implements $FoodItemCopyWith<$Res> {
  factory _$FoodItemCopyWith(_FoodItem value, $Res Function(_FoodItem) then) =
      __$FoodItemCopyWithImpl<$Res>;
  @override
  $Res call({String? id, String? body, String foodName, String imageUrl});
}

/// @nodoc
class __$FoodItemCopyWithImpl<$Res> extends _$FoodItemCopyWithImpl<$Res>
    implements _$FoodItemCopyWith<$Res> {
  __$FoodItemCopyWithImpl(_FoodItem _value, $Res Function(_FoodItem) _then)
      : super(_value, (v) => _then(v as _FoodItem));

  @override
  _FoodItem get _value => super._value as _FoodItem;

  @override
  $Res call({
    Object? id = freezed,
    Object? body = freezed,
    Object? foodName = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_FoodItem(
      id: id == freezed ? _value.id : id as String?,
      body: body == freezed ? _value.body : body as String?,
      foodName: foodName == freezed ? _value.foodName : foodName as String,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_FoodItem extends _FoodItem with DiagnosticableTreeMixin {
  const _$_FoodItem(
      {this.id,
      this.body,
      required this.foodName,
      this.imageUrl = 'https://i.imgur.com/QKYJihU.png'})
      : super._();

  factory _$_FoodItem.fromJson(Map<String, dynamic> json) =>
      _$_$_FoodItemFromJson(json);

  @override
  final String? id;
  @override
  final String? body;
  @override
  final String foodName;
  @JsonKey(defaultValue: 'https://i.imgur.com/QKYJihU.png')
  @override
  final String imageUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FoodItem(id: $id, body: $body, foodName: $foodName, imageUrl: $imageUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FoodItem'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('foodName', foodName))
      ..add(DiagnosticsProperty('imageUrl', imageUrl));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FoodItem &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.body, body) ||
                const DeepCollectionEquality().equals(other.body, body)) &&
            (identical(other.foodName, foodName) ||
                const DeepCollectionEquality()
                    .equals(other.foodName, foodName)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(body) ^
      const DeepCollectionEquality().hash(foodName) ^
      const DeepCollectionEquality().hash(imageUrl);

  @JsonKey(ignore: true)
  @override
  _$FoodItemCopyWith<_FoodItem> get copyWith =>
      __$FoodItemCopyWithImpl<_FoodItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_FoodItemToJson(this);
  }
}

abstract class _FoodItem extends FoodItem {
  const _FoodItem._() : super._();
  const factory _FoodItem(
      {String? id,
      String? body,
      required String foodName,
      String imageUrl}) = _$_FoodItem;

  factory _FoodItem.fromJson(Map<String, dynamic> json) = _$_FoodItem.fromJson;

  @override
  String? get id;
  @override
  String? get body;
  @override
  String get foodName;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$FoodItemCopyWith<_FoodItem> get copyWith;
}
