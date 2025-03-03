import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<Map<String, String>> history = [
    {
      "id": "#HIST001",
      "product": "Wooden Mirror Set",
      "price": "₱3,000.00",
      "date": "February 25, 2025",
    },
    {
      "id": "#HIST002",
      "product": "Hand Blender",
      "price": "₱1,200.00",
      "date": "February 20, 2025",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.green[900],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(Icons.history, color: Colors.blue),
              title: Text(item['product']!),
              subtitle: Text("Date: ${item['date']}"),
              trailing: Text(
                item['price']!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
