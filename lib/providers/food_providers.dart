import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodcast/models/food_item.dart';

final streamFoodItemProvider = StreamProvider(
  (context) => foodItems(),
);

Stream<List<FoodItem>> foodItems() {
  return FirebaseFirestore.instance
      .collection('foods')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) => FoodItem.fromDocument(doc)).toList();
  });
}
