import 'package:flutter/material.dart';

const Color activeColor = Color(0xFF111111);
const Color deactiveColor = Color(0xFF8a8d94);
const Color sidebarColor = Color(0xFFDEE8FF);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

Container customInputBox(String hint, Icon icon, TextInputType inputType,
    TextEditingController textController,
    {@required bool obscureText}) {
  return Container(
    alignment: Alignment.centerLeft,
    decoration: kBoxDecorationStyle,
    height: 60.0,
    child: TextField(
      controller: textController,
      obscureText: obscureText,
      keyboardType: inputType,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(top: 14.0),
        prefixIcon: icon,
        hintText: 'Enter your $hint',
        hintStyle: TextStyle(
          color: Colors.white54,
        ),
      ),
    ),
  );
}
