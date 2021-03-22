import 'package:flutter/material.dart';
import 'package:foodcast/constants.dart';
import 'package:foodcast/views/add_food_page.dart';
import 'package:foodcast/views/calendar_page.dart';
import 'package:foodcast/views/food_page.dart';
import 'package:foodcast/views/recipe_page.dart';
import 'package:foodcast/views/settings_page.dart';
import 'package:foodcast/views/today_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FoodPage()));
        },
        backgroundColor: sidebarColor,
        child: Icon(
          Icons.add,
          color: activeColor,
        ),
      ),
      backgroundColor: Colors.white,
      body: Row(
        children: <Widget>[
          buildNavigationRail(width, height),
          navigationTabs[_selectedIndex]
        ],
      ),
    );
  }

  final navigationTabs = [
    CalendarPage(),
    TodayPage(),
    RecipePage(),
  ];

  NavigationRail buildNavigationRail(double width, double height) {
    return NavigationRail(
      minWidth: width / 8,
      groupAlignment: 1.0,
      backgroundColor: sidebarColor,
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(
          () {
            _selectedIndex = index;
          },
        );
      },
      labelType: NavigationRailLabelType.all,
      leading: Column(
        children: [
          SizedBox(
            height: height / 30,
          ),
          IconButton(
              icon: Icon(
                Icons.search,
                color: deactiveColor,
              ),
              onPressed: () {}),
        ],
      ),
      destinations: [
        buildRotatedTextRailDestination("Calendar"),
        buildRotatedTextRailDestination("Today"),
        buildRotatedTextRailDestination("Recipes"),
      ],
      trailing: Column(
        children: [
          SizedBox(
            height: height / 6,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: IconButton(
                icon: Icon(
                  Icons.tune,
                  color: deactiveColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                }),
          )
        ],
      ),
      selectedLabelTextStyle: TextStyle(
        color: activeColor,
      ),
      unselectedLabelTextStyle: TextStyle(
        color: deactiveColor,
      ),
    );
  }
}

NavigationRailDestination buildRotatedTextRailDestination(String text) {
  return NavigationRailDestination(
    icon: SizedBox.shrink(),
    label: Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: RotatedBox(
        quarterTurns: 3,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    ),
  );
}
