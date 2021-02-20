import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:foodcast/providers/database_providers.dart';
import 'package:foodcast/views/add_food.dart';

class FoodList extends StatelessWidget {
  List<QueryDocumentSnapshot> _foodList;
  FoodList(
      this._foodList); // the list of movies we get via the Homescreen widget.

  @override
  Widget build(BuildContext context) {
    final database = context.read(databaseProvider);
    return _foodList.length != 0 // if no movies , then handle that case
        ? ListView.separated(
            itemCount:
                _foodList.length, // the total count of movies in database .
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              final _currentFood = _foodList[index]
                  .data(); // get the current_movie for displayng it .
              return Dismissible(
                // So as to delete the movie as it is slided .
                onDismissed: (_) async {
                  await database.removeFood(_foodList[index].id).then((res) {
                    // call the removeMovie method of our Database class
                    if (res) {
                      // handle if further logic is required (Eg : display a message )
                    } else {}
                  });
                },
                key: Key(_foodList[index]
                    .id), // Key is needed to be unique , so assigning it with the unique firebase document id
                child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(
                          8.0), // for displaying the movie poster image
                    ),
                    title: Text(
                      _currentFood['name'], // the movie name
                    ), // the movie length
                    trailing: IconButton(
                      icon: Icon(Icons.edit_outlined), // edit a movie
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddFood(
                                    // this is the same widget used for adding a screen.
                                    isFromEdit:
                                        true, // this will distinguish between Edit and Add movie
                                    food: _currentFood,
                                    documentId: _foodList[index]
                                        .id, // the current movieId , so as to be able to edit it
                                  )),
                        );
                      },
                    )),
              );
            })
        : Center(child: Text('No Foods yet'));
  }
}
