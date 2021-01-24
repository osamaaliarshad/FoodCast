import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodcast/constants.dart';

class RecipePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
        child: MediaQuery.removePadding(
          context: context,
          child: GridView.count(
            crossAxisCount: 2,
            children: <Widget>[
              createStyleCard('Nihari', 'nihari.jpg'),
              createStyleCard('Biryani', 'biryani.jpg'),
              createStyleCard('Chicken 65', 'chicken65.jpg'),
              createStyleCard('Shawarma', 'shawarma.jpg'),
              createStyleCard('Falafel', 'falafel.jpg'),
              createStyleCard('Philly Cheese Steak', 'phillycheese.jpg'),
              createStyleCard('Sizzling Chicken', 'sizzlingchicken.jpg'),
              createStyleCard('Haleem', 'haleem.png'),
              createStyleCard('Steak', 'chickensteak.png'),
              createStyleCard('Burrito', 'burrito.jpeg'),
              createStyleCard('Taco', 'taco.jpg'),
              createStyleCard('Burger', 'burger.jpg'),
              createStyleCard('Quesadilla', 'quesadilla.jpg'),
              createStyleCard('Paratha Roll', 'paratharoll.jpg'),
              createStyleCard('Chicken Mundee', 'chickenmundi.jpg'),
              createStyleCard('BBQ Tandoori Chicken', 'bbqtandoori.jpg'),
              createStyleCard('Tandoori Chicken and Yellow Rice',
                  'tandoorichickenandyellowrice.jpg'),
              createStyleCard('Khow Suey', 'khowsuey.png'),
              createStyleCard('Singaporean Rice', 'singaporeanrice.jpg'),
              createStyleCard('Chicken Manchurian', 'chickenmanchurian.jpg'),
              createStyleCard('Chicken Jalfrezi', 'chickenjalfrezi.jpg'),
              createStyleCard('Chicken Makhani', 'chickenmakhani.jpg'),
              createStyleCard('Cheese\nGarlic\nBread', 'cheesegarlicbread.jpg'),
              createStyleCard('Chicken Sandwich', 'chickensandwich.jpg'),
              createStyleCard(
                  'Leaf Chicken Sandwich', 'leafchickensandwich.jpg'),
              createStyleCard('Chicken Egg Sandiwch', 'chickeneggsandwich.jpg'),
              createStyleCard('Spanish Rice', 'spanishrice.jpg'),
              createStyleCard('Green Chicken', 'greenchicken.jpg'),
              createStyleCard('Chapli Kebab', 'chaplikebab.jpg'),
              createStyleCard('Chicken Wings', 'chickenwings.jpg'),
              createStyleCard('Chicken Korma', 'chickenkorma.png'),
              createStyleCard('Chicken Karahi', 'chickenkarahi.jpg'),
              createStyleCard('Sliders', 'sliders.jpeg'),
              createStyleCard('Pizza', 'pizza.JPG'),
            ],
          ),
        ),
      ),
    );
  }
}

Card createStyleCard(String food, String image) {
  return Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/food_images/$image'),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(
            alignment: Alignment.center,
            color: Colors.grey.withOpacity(0.3),
            child: Text(
              food,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 17.0, color: activeColor, fontFamily: 'Raleway'),
            ),
          ),
        ),
      ),
    ),
  );
}
