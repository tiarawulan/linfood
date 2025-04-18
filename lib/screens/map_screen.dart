import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  final String umkmName;
  final String address;

  const MapScreen({Key? key, required this.umkmName, required this.address})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(umkmName),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text(
          'Maps untuk lokasi: $address',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
