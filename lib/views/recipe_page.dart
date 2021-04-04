import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:foodcast/models/food_item.dart';
import 'package:foodcast/providers/food_providers.dart';
import 'package:foodcast/views/food_page.dart';

enum Action { Edit, Delete }

class RecipePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final foods = watch(streamFoodItemProvider);
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        foods.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
          data: (foods) => Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(
                foods.length,
                (index) {
                  final foodItem = foods[index];
                  return GestureDetector(
                    child: CreateStyleCard(foodItem: foodItem),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoodPage(
                            food: foodItem,
                          ),
                        ),
                      );
                    },
                    onLongPressStart: (LongPressStartDetails details) async {
                      await showRecipePagePopupMenu(context, foodItem, details);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Future showRecipePagePopupMenu(BuildContext context, FoodItem foodItem,
      LongPressStartDetails details) async {
    double left = details.globalPosition.dx;
    double top = details.globalPosition.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 100000, 0),
      items: [
        PopupMenuItem(
          value: Action.Edit,
          child: Text("Edit"),
        ),
        PopupMenuItem(
          value: Action.Delete,
          child: Text("Delete"),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      switch (value) {
        case Action.Edit:
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FoodPage(
                food: foodItem,
              ),
            ),
          );
          break;
        case Action.Delete:
          showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                    contentPadding: EdgeInsets.all(18),
                    children: [
                      Text('Are you sure you want to delete'),
                      Text(
                        foodItem.foodName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('foods')
                                  .doc(foodItem.id)
                                  .delete()
                                  .then((value) => Navigator.of(context).pop());
                            },
                            child: Text('Delete'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent,
                            ),
                          ),
                          SizedBox(width: 20),
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('Cancel'))
                        ],
                      )
                    ],
                  ));
          break;
        default:
      }
    });
  }
}

class CreateStyleCard extends StatelessWidget {
  final FoodItem foodItem;

  const CreateStyleCard({Key key, this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            // consumer widget for loading icon?
            image: NetworkImage(foodItem.imageURL.toString()),
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
              color: Colors.black.withOpacity(0.3),
              child: Text(
                foodItem.foodName.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 17.0, color: Colors.white, fontFamily: 'Raleway'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
