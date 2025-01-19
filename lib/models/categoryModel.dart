import 'dart:ui';

import 'package:flutter/material.dart';

class Categorymodel {
  String id;
  String name;
  String image;
  Color color;

  Categorymodel(
      {required this.id,
      required this.name,
      required this.image,
      required this.color});

  static List<Categorymodel> getCategory (){
  return[
    Categorymodel(id: 'business', name: 'business', image: 'assets/images/bussines.png', color: Colors.orangeAccent),
    Categorymodel(id: 'entertainment', name: 'entertainment', image: 'assets/images/environment.png', color: Colors.lightBlueAccent),
    Categorymodel(id: 'health', name: 'health', image: 'assets/images/health.png', color: Colors.pink),
    Categorymodel(id: 'science', name: 'science', image: 'assets/images/science.png', color: Colors.yellow),
    Categorymodel(id: 'sports', name: 'sports', image: 'assets/images/sports.png', color: Colors.red),
    Categorymodel(id: 'technology', name: 'technology ', image: 'assets/images/tech.png', color: Colors.purple)
  ];
  }
}
