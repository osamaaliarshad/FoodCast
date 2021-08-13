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

  var foods;
  @override
  void initState() {
    super.initState();
    //var _data = List.generate(foods.data?.length, (index) => foods[index]);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final foodProvider = context.read(foodItemListControllerProvider.state);

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
                    loading: () => Container(
                      height: height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: CircularProgressIndicator()),
                          SizedBox(height: 250)
                        ],
                      ),
                    ),
                    error: (err, stack) => Text('Error: $err'),
                    data: (foods) {
                      randomItem = randomizer(foods);
                      return foods.isEmpty
                          ? Container(
                              height: height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('No foods have been added yet!'),
                                  SizedBox(height: 250)
                                ],
                              ),
                            )
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
                                        addFoodToToday(context, foods);
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

  void addFoodToToday(BuildContext context, List<FoodItem> foods) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        contentPadding: EdgeInsets.all(18),
        children: [
          Text("Add this food to today's food?"),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  context
                      .read(foodItemListControllerProvider)
                      .updateItem(
                        updatedItem: foods[randomItem!].copyWith(
                          lastMade: DateTime.now(),
                        ),
                      )
                      .then(
                        (value) => Navigator.of(context).pop(),
                      );
                },
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green.shade100,
                ),
              ),
              SizedBox(width: 20),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              )
            ],
          )
        ],
      ),
    );
  }
}

class RecommendedFood {
  var foodList;

  // if a food's last made date exceeds its frequency value, or if the last made
  // date is null add it to the list of recommended food for today
  RecommendedFood(this.foodList);

  Future<void> retrieveFoodNames() async {
    print(foodList);
  }
}
