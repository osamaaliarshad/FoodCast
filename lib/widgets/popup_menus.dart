import 'package:flutter/material.dart';
import 'package:foodcast/controller/food_list_controller.dart';
import 'package:foodcast/models/food_item_model.dart';
import 'package:foodcast/widgets/constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum Action { Edit, Delete }

Future showRecipePagePopupMenu(BuildContext context, FoodItem foodItem,
    LongPressStartDetails details) async {
  double left = details.globalPosition.dx;
  double top = details.globalPosition.dy;
  await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(left, top, 100000, 0),
    items: [
      PopupMenuItem(
        value: Action.Delete,
        child: Text("Delete"),
      ),
    ],
    elevation: 8.0,
  ).then((value) {
    switch (value) {
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
                            context
                                .read(foodItemListControllerProvider)
                                .deleteItem(foodItemId: foodItem.id!)
                                .then((value) => Navigator.of(context).pop());
                          },
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red.shade200,
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

Future<dynamic> showCalendarPageMenu(
    BuildContext context, double left, double top, FoodItem foodItem) {
  return showMenu(
    context: context,
    position: RelativeRect.fromLTRB(left, top, 100000, 0),
    items: [
      PopupMenuItem(
        value: 'Remove',
        child: Text("Remove from this day"),
      ),
    ],
    elevation: 8.0,
  ).then((value) {
    switch (value) {
      case 'Remove':
        showDialog(
            context: context,
            builder: (context) => SimpleDialog(
                  contentPadding: EdgeInsets.all(18),
                  children: [
                    Text('Are you sure you want to remove from this date?'),
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
                            context
                                .read(foodItemListControllerProvider)
                                .updateItem(
                                    updatedItem:
                                        foodItem.copyWith(lastMade: null))
                                .then(
                                  (value) => Navigator.of(context).pop(),
                                );
                          },
                          child: Text(
                            'Remove',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red.shade200,
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
    }
  });
}
