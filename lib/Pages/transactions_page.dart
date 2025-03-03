import 'package:flutter/material.dart';

class TransactionsPage extends StatelessWidget {
  final List<Map<String, dynamic>> transactions = [
    {
      "id": "#TXN001",
      "product": "Hair Dryer",
      "price": "₱1,500.00",
      "date": "March 3, 2025",
      "status": "Pending",
    },
    {
      "id": "#TXN002",
      "product": "Essential Oil",
      "price": "₱500.00",
      "date": "March 2, 2025",
      "status": "Completed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
        backgroundColor: Colors.green[900],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(Icons.shopping_bag, color: Colors.green[700]),
              title: Text(transaction['product']),
              subtitle: Text("Date: ${transaction['date']}"),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(transaction['price'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(transaction['status'],
                      style: TextStyle(
                          color: transaction['status'] == "Completed"
                              ? Colors.green
                              : Colors.red)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
