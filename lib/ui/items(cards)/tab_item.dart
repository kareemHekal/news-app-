import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  String source;
  bool isSelected;

  TabItem({required this.source, required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
      color: isSelected ? Colors.green : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.green,
          width: 2)
      ),
      child: Text(
        source,
        style: TextStyle(
            color: isSelected ? Colors.white : Colors.green,
        ),
      ),
    );
  }
}
