import 'package:flutter/material.dart';

import '../../models/categoryModel.dart';
import '../pages/home.dart';


class Catogeryitem extends StatelessWidget {
  Categorymodel categorymodel;
  bool IsLeft;

  Catogeryitem({required this.IsLeft, required this.categorymodel, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(category: categorymodel.id,)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: categorymodel.color,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: IsLeft? Radius.circular(30):Radius.circular(0),
                bottomRight: IsLeft? Radius.circular(0):Radius.circular(30),)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              categorymodel.image,
              height: 160,
            ),
            Text(categorymodel.name,style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)
          ],
        ),
      ),
    );
  }
}
