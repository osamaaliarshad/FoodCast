import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FoodItem {
  FoodItem({this.id, this.foodName, this.imageURL});
  String foodName;
  final String id;
  final String imageURL;

  factory FoodItem.fromDocument(DocumentSnapshot doc) {
    final map = doc?.data();
    if (map == null) return null;

    return FoodItem(
        foodName: map['foodName'], id: doc.id, imageURL: map['imageURL']);
  }
  //AssetImage imageAsset = AssetImage('assets/food_images/default.png');

  Map<String, dynamic> toMap() {
    return {
      'foodName': foodName,
      'imageURL': imageURL,
    };
  }
}
