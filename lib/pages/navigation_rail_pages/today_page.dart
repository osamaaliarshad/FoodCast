import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodcast/controller/food_list_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodayPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final foods = useProvider(foodItemListControllerProvider.state);

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
                      return foods.isEmpty
                          ? Text('No foods have been added yet!')
                          : Text(
                              foods[Random().nextInt(foods.length)]
                                  .foodName
                                  .toString(),
                            );
                    }),
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
