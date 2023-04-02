import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/item_service.dart';

class EditItemScreen extends StatefulWidget {
  final String documentId;
  final TextEditingController _itemName = TextEditingController();
  final TextEditingController _itemMorning = TextEditingController();
  final TextEditingController _itemNoon = TextEditingController();
  final TextEditingController _itemDinner = TextEditingController();
  final TextEditingController _itemEvening = TextEditingController();

  EditItemScreen(this.documentId, String itemName, String itemMorning,
      String itemNoon, String itemDinner, String itemEvening) {
    _itemName.text = itemName;
    _itemMorning.text = itemMorning;
    _itemNoon.text = itemNoon;
    _itemDinner.text = itemDinner;
    _itemEvening.text = itemEvening;
  }

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final ItemService _itemService = ItemService();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15));
    return Scaffold(
      appBar: AppBar(
        title: const Text("แก้ไขรายการ"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: widget._itemName,
              decoration: const InputDecoration(label: Text("วันที่")),
            ),
            TextField(
              controller: widget._itemMorning,
              decoration: const InputDecoration(label: Text("มื้อเช้า")),
            ),
            TextField(
              controller: widget._itemNoon,
              decoration: const InputDecoration(label: Text("มื้อเที่ยง")),
            ),
            TextField(
              controller: widget._itemDinner,
              decoration: const InputDecoration(label: Text("มื้อเย็น")),
            ),
            TextField(
              controller: widget._itemEvening,
              decoration: const InputDecoration(label: Text("มื้อค่ำ")),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: style,
                onPressed: _deleteItem,
                child: const Text("ลบรายการ")),
            const SizedBox(height: 10),
            ElevatedButton(
                style: style, onPressed: _editItem, child: const Text("แก้ไข")),
          ],
        ),
      ),
    );
  }

  void _editItem() {
    final String newName = widget._itemName.text;
    final String newMorning = widget._itemMorning.text;
    final String newNoon = widget._itemNoon.text;
    final String newDinner = widget._itemDinner.text;
    final String newEvening = widget._itemEvening.text;

    if (newName.isNotEmpty &&
        newMorning.isNotEmpty &&
        newNoon.isNotEmpty &&
        newDinner.isNotEmpty &&
        newEvening.isNotEmpty) {
      _itemService.updateItem(widget.documentId, {
        'name': newName,
        'morning': newMorning,
        'noon': newNoon,
        'dinner': newDinner,
        'evening': newEvening,
      }).then((value) {
        Navigator.pop(context);
      }).catchError((error) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(error.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Success'),
              ),
            ],
          ),
        );
      });
    }
  }

  void _deleteItem() {
    _itemService.deleteItem(widget.documentId).then((value) {
      Navigator.pop(context);
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Delete Success'),
            ),
          ],
        ),
      );
    });
  }
}
