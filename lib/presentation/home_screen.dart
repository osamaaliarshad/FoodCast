import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

const Color activeColor = Color(0xFF192248);
const Color deactiveColor = Color(0xFFB9B9C0);

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    return Scaffold(
      backgroundColor: Color(0xFFFBFAFD),
      body: Center(
        child: Row(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 6,
                  color: Color(0xFFFDF0E2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RotatedBox(
                        quarterTurns: 0,
                        child: Icon(
                          Icons.reorder,
                          color: deactiveColor,
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 0,
                        child: Icon(
                          Icons.search,
                          color: deactiveColor,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          print('object');
                        },
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            'Calendar',
                            style: TextStyle(color: deactiveColor),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('object2');
                        },
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            'Today',
                            style: TextStyle(color: activeColor),
                          ),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          'Recipes',
                          style: TextStyle(color: deactiveColor),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Icon(
                          Icons.settings,
                          color: deactiveColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
