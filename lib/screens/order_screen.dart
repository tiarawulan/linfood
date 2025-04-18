import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  // Constructor dengan parameter 'item'
  OrderScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['name'] ?? 'Pemesanan'),
      ),
      body: Center(
        child: Text('Pesan: ${item['name']}'),
      ),
    );
  }
}
