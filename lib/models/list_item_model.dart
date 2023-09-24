import 'package:flutter/material.dart';

class ListItemModel {
  final List<Map<String, dynamic>> initialItems;

  ListItemModel(this.initialItems);

  factory ListItemModel.defaultItems() {
    return ListItemModel([
      {'text': 'Item 0', 'color': Colors.deepOrange},
      {'text': 'Item 1', 'color': Colors.deepPurple},
      {'text': 'Item 2', 'color': Colors.cyan},
      {'text': 'Item 3', 'color': Colors.blueGrey},
      {'text': 'Item 4', 'color': Colors.blueAccent},
    ]);
  }
}
