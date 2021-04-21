import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodcast/pages/navigation_rail_pages/recipe/food_info_page.dart';
import 'package:foodcast/widgets/constants.dart';
import 'package:foodcast/widgets/popup_menus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodcast/controller/food_list_controller.dart';
import 'package:foodcast/models/food_item_model.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

enum Action { Edit, Delete }

class RecipePage extends StatefulWidget {
  @override
  _RecipePageState createState() => _RecipePageState();
}

FloatingSearchBarController? controller;

@override
void initState() {
  controller = FloatingSearchBarController();
}

@override
void dispose() {
  controller?.dispose();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoodInfoPage(
                food: FoodItem.empty(),
              ),
            ),
          ),
          backgroundColor: sidebarColor,
          child: Icon(
            Icons.add,
            color: activeColor,
          ),
        ),
        body: FloatingSearchBar(
          onSubmitted: (query) {
            setState(() {});
            controller?.close();
          },
          onQueryChanged: (query) {
            setState(() {});
          },
          actions: [
            FloatingSearchBarAction.searchToClear(),
          ],
          transition: CircularFloatingSearchBarTransition(),
          // Bouncing physics for the search history
          physics: BouncingScrollPhysics(),

          controller: controller,
          builder: (context, transition) {
            return Text('');
          },
          body: RefreshIndicator(
            onRefresh: () async {
              setState(() {});
              context.refresh(foodItemListControllerProvider);
            },
            child: FloatingSearchBarScrollNotifier(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 55,
                  ),
                  Expanded(
                    child: Consumer(
                      builder: (context, watch, child) {
                        var foods = watch(foodItemListControllerProvider.state);
                        return foods.when(
                          loading: () =>
                              Center(child: CircularProgressIndicator()),
                          error: (err, stack) => Text('Error: $err'),
                          data: (foods) => foods.isEmpty
                              ? Center(child: Text('Tap + to add a food item.'))
                              : (GridView.count(
                                  crossAxisCount: 2,
                                  children: List.generate(
                                    foods.length,
                                    (index) {
                                      final foodItem = foods[index];
                                      return GestureDetector(
                                        child:
                                            CreateStyleCard(foodItem: foodItem),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FoodInfoPage(
                                                food: foodItem,
                                              ),
                                            ),
                                          );
                                        },
                                        onLongPressStart: (LongPressStartDetails
                                            details) async {
                                          showRecipePagePopupMenu(
                                              context, foodItem, details);
                                          //show popup menu to delete item
                                        },
                                      );
                                    },
                                  ),
                                )),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CreateStyleCard extends StatelessWidget {
  final FoodItem foodItem;

  const CreateStyleCard({Key? key, required this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            // consumer widget for loading icon?
            image: NetworkImage(foodItem.imageUrl.toString()),
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
