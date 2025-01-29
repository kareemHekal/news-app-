import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/ui/pages/News%20Home%20page.dart';

import 'Search Page.dart';
import 'drawerWidget.dart';

class HomeScreen extends StatelessWidget {
  String category;

  HomeScreen({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image:
              DecorationImage(image: AssetImage("assets/images/pattern.png"))),
      child: Scaffold(
        drawer: Drawerwidget(),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchPage());
                },
              icon: const Icon(Icons.search, color: Colors.white),
            ),
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          iconTheme: const IconThemeData(color: Colors.white, size: 30),
          centerTitle: true,
          toolbarHeight: 100,
          backgroundColor: Colors.green,
          title: Text(
            category,
            style: const TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w300),
          ),
        ),
        body: NewsUI(category: category),
      ),
    );
  }
}
