import 'package:flutter/material.dart';

import 'categories page.dart';

class Drawerwidget extends StatelessWidget {
  Drawerwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        children: [
          Container(
            height: 120,
            color: Colors.green,
            child: const Center(
              child: Text(
                "new app",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => CategoriesPage()),
                  (route) => false);
            },
            child: const ListTile(
              leading: Icon(
                Icons.menu,
                size: 40,
              ),
              title: Text(
                "Categories",
                style: TextStyle(fontSize: 30),
              ),
            ),
          )
        ],
      ),
    );
  }
}
