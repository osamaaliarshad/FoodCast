import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

const Color activeColor = Color(0xFF192248);
const Color deactiveColor = Color(0xFFB9B9C0);

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
      backgroundColor: Color(0xFFFBFAFD),
      body: Row(
        children: <Widget>[
          NavigationRail(
            minWidth: width / 8,
            groupAlignment: 1.0,
            backgroundColor: Color(0xFFFDF0E2),
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: [
              buildRotatedTextRailDestination("Calendar"),
              buildRotatedTextRailDestination("Today"),
              buildRotatedTextRailDestination("Recipes"),
            ],
            trailing: Column(
              children: [
                SizedBox(
                  height: height / 8,
                ),
                SizedBox(
                  height: height / 105,
                ),
                IconButton(icon: Icon(Icons.tune), onPressed: () {})
              ],
            ),
            selectedLabelTextStyle: TextStyle(
              color: activeColor,
              letterSpacing: 0.8,
            ),
            unselectedLabelTextStyle: TextStyle(
              color: deactiveColor,
              letterSpacing: 0.8,
            ),
          ),

          // VerticalDivider(
          //   thickness: 1,
          //   width: 1,
          //   color: Colors.black,
          // ),

          // This is the main content.
          ContentSpace(_selectedIndex)
        ],
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
        child: Text(text),
      ),
    ),
  );
}

class ContentSpace extends StatelessWidget {
  final int _selectedIndex;
  ContentSpace(this._selectedIndex);

  final List<String> titles = [
    "Calendar",
    "Today's\nFood",
    "All\nRecipes",
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 0, 0),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 24,
              ),
              Text(titles[_selectedIndex],
                  style: Theme.of(context).textTheme.headline4),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
