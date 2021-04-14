import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodcast/controller/food_list_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'recipe/food_info_page.dart';

class TodayPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final foods = useProvider(foodItemListControllerProvider.state);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 24,
              ),
              Text("Today's\nFood",
                  style: Theme.of(context).textTheme.headline4),
              SizedBox(
                height: 24,
              ),
              foods.when(
                  loading: () => const CircularProgressIndicator(),
                  error: (err, stack) => Text('Error: $err'),
                  data: (foods) {
                    int randomItem = Random().nextInt(foods.length);
                    return foods.isEmpty
                        ? Text('No foods have been added yet!')
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(foods[randomItem].foodName.toString(),
                                  style: Theme.of(context).textTheme.headline5),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FoodInfoPage(
                                        food: foods[randomItem],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: height / 1.5,
                                  width: width / .3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      foods[randomItem].imageUrl.toString(),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.shuffle),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.check),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
