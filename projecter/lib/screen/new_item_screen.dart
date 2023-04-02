import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projecter/services/item_service.dart';
import 'package:logger/logger.dart';

class NewItemScreen extends StatefulWidget {
  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final _itemName = TextEditingController();
  final _itemMorning = TextEditingController();
  final _itemNoon = TextEditingController();
  final _itemDinner = TextEditingController();
  final _itemEvening = TextEditingController();

  final ItemService _itemService = ItemService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _itemName,
              decoration: InputDecoration(label: Text("วันที่")),
            ),
            TextField(
              controller: _itemMorning,
              decoration: InputDecoration(label: Text("มื้อเช้า")),
            ),
            TextField(
              controller: _itemNoon,
              decoration: InputDecoration(label: Text("มื้อเที่ยง")),
            ),
            TextField(
              controller: _itemDinner,
              decoration: InputDecoration(label: Text("มื้อเย็น")),
            ),
            TextField(
              controller: _itemEvening,
              decoration: InputDecoration(label: Text("มื้อดึก")),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: _addItem, child: const Text("Save"))
          ],
        ),
      ),
    );
  }

  _addItem() {
    _itemService.addItem2Firebase(_itemName.text, {
      "name": _itemName.text,
      "morning": _itemMorning.text,
      "noon": _itemNoon.text,
      "dinner": _itemDinner.text,
      "evening": _itemEvening.text
    });
  }
}
