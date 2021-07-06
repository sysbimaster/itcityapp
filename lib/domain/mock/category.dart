import 'package:flutter/material.dart';

class Category {
  String name;
  Icon icon;

  Category({String n, Icon i}) {
    name = n;
    icon = i;
  }
}

List<Category> categories = [
  Category(
      n: 'Computer',
      i: Icon(
        Icons.computer,
        color: Colors.redAccent,
      )),
  Category(n: 'Tablet', i: Icon(Icons.tablet, color: Colors.redAccent)),
  Category(n: 'laptop', i: Icon(Icons.laptop_sharp, color: Colors.redAccent)),
  Category(n: 'phone', i: Icon(Icons.phone_android, color: Colors.redAccent)),
  Category(n: 'i phone', i: Icon(Icons.phone_iphone, color: Colors.redAccent)),
];
