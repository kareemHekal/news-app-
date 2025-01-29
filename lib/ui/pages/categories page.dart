import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/categoryModel.dart';
import '../items(cards)/catogeryItem.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({super.key});

  final categories = Categorymodel.getCategory();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: AssetImage("assets/images/pattern.png"))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          centerTitle: true,
          toolbarHeight: 100,
          backgroundColor: Colors.green,
          title: const Text(
            "News app",
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w300),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '''
       Pick your category 
       of interest
                ''',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Catogeryitem(
                      categorymodel: categories[index],
                      IsLeft: index.isEven,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
