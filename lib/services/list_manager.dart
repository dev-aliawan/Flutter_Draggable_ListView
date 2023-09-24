import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListManager {
  // Function to load list order from SharedPreferences
  Future<void> loadListOrder(List<Map<String, dynamic>> items, Function(List<Map<String, dynamic>>) callback) async {
    final prefs = await SharedPreferences.getInstance();
    final order = prefs.getStringList('list_order');
    if (order != null) {
      final orderedItems = order.map((itemText) {
        final item = items.firstWhere((element) => element['text'] == itemText);
        return item;
      }).toList();
      callback(orderedItems); // Call the callback to update the list
    }
  }

  // Function to reorder list items
  Future<void> reorderList(int oldIndex, int newIndex, List<Map<String, dynamic>> items) async {
    if (oldIndex < newIndex) {
      newIndex--; // Adjust the new index if moving down the list
    }
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    await saveListOrder(items); // Save the updated list order to SharedPreferences
  }

  // Function to build list items as widgets
  List<Widget> buildListItems(List<Map<String, dynamic>> items) {
    return List.generate(
      items.length,
      (index) {
        final item = items[index];
        final String text = item['text'];
        final Color color = item['color'];

        return Container(
          color: color,
          key: Key('$index'),
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            title: Text(
              text,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  // Function to save list order to SharedPreferences
  Future<void> saveListOrder(List<Map<String, dynamic>> items) async {
    final prefs = await SharedPreferences.getInstance();
    final order = items.map((item) => item['text']).toList().cast<String>(); // Ensure the list is of type List<String>
    await prefs.setStringList('list_order', order);
  }
}
