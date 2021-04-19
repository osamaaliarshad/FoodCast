import 'dart:math';
import 'package:flutter/material.dart';
import 'package:foodcast/controller/food_list_controller.dart';
import 'package:foodcast/models/food_item_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'recipe/food_info_page.dart';

class TodayPage extends StatefulWidget {
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage>
    with AutomaticKeepAliveClientMixin<TodayPage> {
  int? randomItem;
  int randomizer(List<FoodItem> foods) => Random().nextInt(foods.length);
  @override
  void initState() {
    randomItem = 8;
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    super.build(context);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
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
              Consumer(
                builder: (context, watch, child) {
                  var foods = watch(foodItemListControllerProvider.state);
                  return foods.when(
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (err, stack) => Text('Error: $err'),
                    data: (foods) {
                      // var arr = List.filled(foods.length, 0);
                      // for (int i = 0; i < foods.length; i++) {
                      //   // if a food's last made date exceeds its frequency
                      //   // value, or if the last made
                      //   // date is null add it to the list of recommended food
                      //   // for today
                      // }
                      return foods.isEmpty
                          ? Text('No foods have been added yet!')
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(foods[randomItem!].foodName.toString(),
                                    style:
                                        Theme.of(context).textTheme.headline5),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FoodInfoPage(
                                          food: foods[randomItem!],
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
                                        foods[randomItem!].imageUrl.toString(),
                                        fit: BoxFit.cover,
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
                                      onPressed: () {
                                        setState(() {
                                          randomItem = randomizer(foods);
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.check),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => SimpleDialog(
                                            contentPadding: EdgeInsets.all(18),
                                            children: [
                                              Text(
                                                  "Add this food to today's food?"),
                                              Text(
                                                foods[randomItem!].foodName,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      context
                                                          .read(
                                                              foodItemListControllerProvider)
                                                          .updateItem(
                                                            updatedItem: foods[
                                                                    randomItem!]
                                                                .copyWith(
                                                              lastMade: DateTime
                                                                  .now(),
                                                            ),
                                                          )
                                                          .then(
                                                            (value) =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(),
                                                          );
                                                    },
                                                    child: Text(
                                                      'Yes',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          Colors.green.shade100,
                                                    ),
                                                  ),
                                                  SizedBox(width: 20),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child: Text('Cancel'),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class RecommendedFood {
//   // if a food's last made date exceeds its frequency value, or if the last made
//   // date is null add it to the list of recommended food for today
//   final foodProvider = Provider(
//     (ref) async => await ref.watch(foodItemListControllerProvider.state),
//   );
// }
