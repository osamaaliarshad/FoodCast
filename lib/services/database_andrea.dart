import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

abstract class Databasea {
  Future<void> createFood(Map<String, dynamic> foodData);
}

class FirestoreDatabase implements Databasea {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  // this method takes a map of key value pairs that we want to write in our
  // document
  Future<void> createFood(Map<String, dynamic> foodData) async {
    // we then create this path that represents the location where we are going
    // to write in the firestore database
    final path = '/users/$uid/foods/food_a';
    final documentReference = FirebaseFirestore.instance.doc(path);

    await documentReference.set(foodData);
  }
}
