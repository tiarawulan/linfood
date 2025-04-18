import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OrderPage(),
    );
  }
}

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // Daftar menu
  final List<Map<String, dynamic>> _menuItems = [
    {"name": "Ayam Geprek Komplit + Nasi", "price": 25000},
    {"name": "3T (Tahu Tempe Terong)", "price": 10000},
  ];

  // State untuk jumlah pesanan
  final Map<String, int> _orderCount = {};

  // Menambahkan item ke dalam jumlah pesanan
  void _incrementOrder(String itemName) {
    setState(() {
      _orderCount[itemName] = (_orderCount[itemName] ?? 0) + 1;
    });
  }

  // Mengurangi item dari jumlah pesanan
  void _decrementOrder(String itemName) {
    setState(() {
      if (_orderCount[itemName] != null && _orderCount[itemName]! > 0) {
        _orderCount[itemName] = _orderCount[itemName]! - 1;
        if (_orderCount[itemName] == 0) {
          _orderCount.remove(itemName);
        }
      }
    });
  }

  // Menghitung total harga dari semua pesanan
  int _calculateTotalPrice() {
    int totalPrice = 0;
    _orderCount.forEach((itemName, quantity) {
      final item = _menuItems.firstWhere((menu) => menu["name"] == itemName);
      totalPrice += (item["price"] as int) * quantity;
    });
    return totalPrice;
  }

  // Membuka WhatsApp dengan rincian pesanan
  void _openWhatsApp() async {
    final orderedItems = _orderCount.entries
        .where((entry) => entry.value > 0)
        .toList(); // Hanya tampilkan item yang dipesan
    if (orderedItems.isEmpty) {
      return; // Tidak ada pesanan, tidak membuka WhatsApp
    }

    final totalPrice = _calculateTotalPrice();

    // Buat pesan untuk dikirim ke WhatsApp
    String message = "Halo, saya ingin memesan:\n\n";
    for (var entry in orderedItems) {
      final item = _menuItems.firstWhere((menu) => menu["name"] == entry.key);
      message +=
          "- ${entry.key} x${entry.value} = Rp ${item["price"] * entry.value}\n";
    }
    message += "\nTotal: Rp $totalPrice";

    // Nomor WhatsApp tujuan (ganti dengan nomor tujuan)
    final String phoneNumber = "6283800809844";
    final Uri whatsappUrl = Uri.parse(
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch WhatsApp";
    }
  }

  // Membuka popup untuk menampilkan rincian pesanan
  void _showOrderDetails() {
    showDialog(
      context: context,
      builder: (context) {
        final orderedItems = _orderCount.entries
            .where((entry) => entry.value > 0)
            .toList(); // Hanya tampilkan item yang dipesan
        final totalPrice = _calculateTotalPrice();

        return AlertDialog(
          title: Text("Rincian Pesanan"),
          content: orderedItems.isEmpty
              ? Text("Tidak ada pesanan.")
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...orderedItems.map((entry) {
                      final item = _menuItems
                          .firstWhere((menu) => menu["name"] == entry.key);
                      final itemTotalPrice = item["price"] * entry.value;
                      return ListTile(
                        title: Text(entry.key),
                        subtitle: Text(
                            "Jumlah: ${entry.value} | Total: Rp $itemTotalPrice"),
                      );
                    }).toList(),
                    Divider(),
                    Text(
                      "Total Harga: Rp $totalPrice",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
          actions: [
            TextButton(
              onPressed: _openWhatsApp,
              child: Text("Tutup dan Pesan di WhatsApp"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  final item = _menuItems[index];
                  final itemName = item["name"];
                  final itemPrice = item["price"];
                  final itemCount = _orderCount[itemName] ?? 0;

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                itemName,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Rp $itemPrice",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () => _decrementOrder(itemName),
                              ),
                              Text("$itemCount"),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () => _incrementOrder(itemName),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _showOrderDetails,
              child: Text("Pesan"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}