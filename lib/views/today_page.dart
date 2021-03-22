import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:foodcast/providers/food_providers.dart';

class TodayPage extends ConsumerWidget {
  // var foods = [
  //   'Nihari',
  //   'Biryani',
  //   'Chicken 65',
  //   'Shawarma',
  //   'Falafel',
  //   'Philly Cheese Steak',
  //   'Sizzling Chicken',
  //   'Haleem',
  //   'Steak',
  //   'Burrito',
  //   'Taco',
  //   'Burger',
  //   'Quesadilla',
  //   'Paratha Roll',
  //   'Chicken Mundi',
  //   'BBQ Tandoori Chicken',
  //   'Tandoori Chicken and Yellow Rice',
  //   'Khow Suey',
  //   'Singaporean Rice',
  //   'Chicken Manchurian',
  //   'Chicken Jalfrezi',
  //   'Chicken Makhani',
  //   'Cheese Garlic Bread',
  //   'Chicken Sandwich',
  //   'Leaf Chicken Sandwich',
  //   'Chicken Egg Sandwich',
  //   'Spanish Rice',
  //   'Green Chicken',
  //   'Chapli Kebab',
  //   'Chicken Wings',
  //   'Chicken Korma',
  //   'Chicken Karahi',
  //   'Sliders',
  //   'Pizza'
  // ];

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final double height = MediaQuery.of(context).size.height;
    final foods = watch(streamFoodItemProvider);
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
                height: (height * 0.5) / 1.5,
              ),
              Center(
                child: foods.when(
                  loading: () => const CircularProgressIndicator(),
                  error: (err, stack) => Text('Error: $err'),
                  data: (foods) {
                    var foodItem = foods[Random().nextInt(foods.length)];
                    return Text(
                      foodItem.foodName.toString(),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              IconButton(
                icon: Icon(Icons.shuffle),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
