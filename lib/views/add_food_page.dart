import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodcast/constants.dart';
import 'package:foodcast/models/food_item.dart';
import 'package:foodcast/services/image_capture.dart';

class AddFood extends StatelessWidget {
  final FoodItem food;

  const AddFood({Key key, this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final foodController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Food'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: customInputBox(
                  'Enter food here',
                  Icon(Icons.food_bank, color: Colors.white),
                  TextInputType.name,
                  foodController,
                  obscureText: false),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Submit'),
        icon: Icon(Icons.check),
        backgroundColor: blueColor,
        onPressed: () async {
          final name = foodController.text;
          final foodItem = FoodItem(
            foodName: name,
          );
          await FirebaseFirestore.instance
              .collection('foods')
              .add(foodItem.toMap())
              .then((value) => Navigator.of(context).pop());
        },
      ),
    );
  }
}

// Future<void> handleFoodUpdate(
//     {bool isEdit, FoodItem newFoodItem, FoodItem oldFood}) async {
//   final newMapFood = newFoodItem.toMap();

//   if (isEdit) {
//     await FirebaseFirestore.instance
//         .collection('foods')
//         .doc(oldFood.id)
//         .update(newMapFood);
//   } else {}
// }
