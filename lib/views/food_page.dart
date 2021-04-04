import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodcast/constants.dart';
import 'package:foodcast/models/food_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

Future<PickedFile> getFileImage() async {
  return await ImagePicker().getImage(source: ImageSource.gallery);
}

class FoodPage extends ConsumerWidget {
  final FoodItem food;
  const FoodPage({Key key, this.food}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final isEdit = food != null;
    final foodNameTextController = TextEditingController();
    PickedFile pickedFile;
    //
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () async {
                    pickedFile = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                  })
            ],
            actionsIconTheme: IconThemeData(color: Colors.white),
            expandedHeight: 250,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              title: !isEdit
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: FoodPageTextField(
                        foodNameController: foodNameTextController,
                        hintText: 'Enter food name',
                      ),
                    )
                  : FoodPageTextField(
                      foodNameController: foodNameTextController,
                      hintText: food.foodName.toString(),
                    ),
              centerTitle: true,
              stretchModes: [StretchMode.zoomBackground, StretchMode.fadeTitle],
              background: Stack(fit: StackFit.expand, children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: pickedFile == null
                          ? (isEdit
                              ? NetworkImage(food?.imageURL.toString())
                              : NetworkImage('https://i.imgur.com/QKYJihU.png'))
                          : FileImage(File(pickedFile.path)),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        //height: 200,
                        alignment: Alignment.center,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Text(
              'recipe data here',
              style: TextStyle(fontSize: 200),
            )
          ]))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: blueColor,
        label: Text(isEdit ? 'Update' : 'Add'),
        icon: Icon(isEdit ? Icons.check : Icons.check),
        onPressed: () async {
          String foodsName;
          String imagesURL;
          if (foodNameTextController.text == '') {
            if (food == null) {
              // handle error of not choosing name here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please enter the food name'),
                ),
              );
            }
            foodsName = food.foodName.toString();
          } else {
            foodsName = foodNameTextController.text;
          }
          if (pickedFile != null) {
            TaskSnapshot snapshot = await FirebaseStorage.instance
                .ref()
                .child('images/${DateTime.now()}')
                .putFile(File(pickedFile.path));
            if (snapshot != null) {
              final String downloadURL = await snapshot.ref.getDownloadURL();
              imagesURL = downloadURL;
            }
          }

          final foodItem = FoodItem(
            foodName: foodsName,
            imageURL: imagesURL == null
                ? 'https://i.imgur.com/QKYJihU.png'
                : imagesURL,
          );
          handleFoodUpdate(
            isEdit: isEdit,
            newFoodItem: foodItem,
            oldFood: food,
          ).then((value) => Navigator.of(context).pop());
        },
      ),
    );
  }
}

Future<void> handleFoodUpdate(
    {bool isEdit, FoodItem newFoodItem, FoodItem oldFood}) async {
  final newMapFood = newFoodItem.toMap();

  if (isEdit) {
    await FirebaseFirestore.instance
        .collection('foods')
        .doc(oldFood.id)
        .update(newMapFood);
  } else {
    await FirebaseFirestore.instance.collection('foods').add(newMapFood);
  }
}

Future<void> uploadImage(File file, FoodItem foodItem,
    TextEditingController foodNameTextController) async {
  TaskSnapshot snapshot =
      await FirebaseStorage.instance.ref().child('foods').putFile(file);
  if (snapshot != null) {
    final String downloadURL = await snapshot.ref.getDownloadURL();
    if (foodItem != null) {
      // if the foodItem already exists (i.e is editing)
      await FirebaseFirestore.instance
          .collection('foods')
          .doc(foodItem.id)
          .update({'imageURL': downloadURL});
    } else {
      // but if the food item doesn't exist and you are adding a new item
      if (foodNameTextController.text.isNotEmpty) {
        // as long as the food name isn't empty
        await FirebaseFirestore.instance
            .collection('foods')
            .add({'imageURL': downloadURL});
      }
    }
  }
}
