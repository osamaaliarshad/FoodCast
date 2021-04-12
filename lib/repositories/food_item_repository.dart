// handles all the crud operations related to items
//
// abstract class ItemBaseRepository {
import 'package:firebase_core/firebase_core.dart';
import 'package:foodcast/general_providers.dart';
import 'package:foodcast/models/food_item_model.dart';
import 'package:foodcast/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:foodcast/widgets/extensions/firebase_firestore_extension.dart';

final foodItemRepositoryProvider =
    Provider((ref) => FoodItemRepository(ref.read));

abstract class BaseFoodItemRepository {
  Future<String> createItem(
      {required String userId, required FoodItem foodItem});
  Future<List<FoodItem>> retrieveItems({required String userId});
  Future<void> updateItem({required String userId, required FoodItem foodItem});
  Future<void> deleteItem({required String userId, required String foodItemId});
}

class FoodItemRepository implements BaseFoodItemRepository {
  final Reader _read;

  const FoodItemRepository(this._read);

  @override
  Future<String> createItem({
    required String userId,
    required FoodItem foodItem,
  }) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .userListRef(userId)
          .add((foodItem.toDocument()));
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<FoodItem>> retrieveItems({required String userId}) async {
    try {
      final snap =
          await _read(firebaseFirestoreProvider).userListRef(userId).get();
      return snap.docs.map((doc) => FoodItem.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> updateItem(
      {required String userId, required FoodItem foodItem}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .userListRef(userId)
          .doc(foodItem.id)
          .update(foodItem.toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteItem(
      {required String userId, required String foodItemId}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .userListRef(userId)
          .doc(foodItemId)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
