import 'package:flutter/material.dart';
import 'package:flutter_draggable_listview/models/list_item_model.dart';

import '../services/list_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> items = ListItemModel.defaultItems().initialItems; // Initialize list with default items

  @override
  void initState() {
    super.initState();
    ListManager().loadListOrder(items, _updateList); // Load list order from SharedPreferences
  }

  void _updateList(List<Map<String, dynamic>> updatedList) {
    setState(() {
      items = updatedList; // Update the list when the order is loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Drag and Drop List',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ReorderableListView(
        onReorder: _onReorder,
        children: ListManager().buildListItems(items), // Pass items directly
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex--;
      }
      final item = items.removeAt(oldIndex);
      items.insert(newIndex, item);
      ListManager().saveListOrder(items);
    });
  }
}
