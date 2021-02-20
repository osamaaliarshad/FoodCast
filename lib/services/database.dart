import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodcast/models/food_item.dart';

class Database {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _foods;

  Stream get allFoods => _firestore.collection('foods').snapshots();

  Stream<FoodItem> itemStream(String foodId) {
    return Stream.empty();
  }

  Future<bool> addNewFood(FoodItem food) async {
    _foods = _firestore.collection('foods');

    try {
      await _foods.add({'foodName': food.foodName});
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> removeFood(String foodID) async {
    _foods = _firestore.collection('foods');
    try {
      await _foods.doc(foodID).delete();
      return true;
    } catch (e) {
      print(e.message);
      return Future.error(e);
    }
  }

  Future<bool> editFood(FoodItem food, String foodID) async {
    _foods = _firestore.collection('foods');
    try {
      await _foods.doc(foodID).update({'foodName': food.foodName});
      return true;
    } catch (e) {
      print(e.message);
      return Future.error(e);
    }
  }
}
