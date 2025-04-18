import 'package:flutter/material.dart';
import 'package:linfood/screens/ProfileScreen.dart';
import 'package:linfood/screens/home_screen.dart';

void main() {
  runApp(MaterialApp(home: HistoryScreen()));
}

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Riwayat',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Transaksi Terbaru",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              // Riwayat transaksi pertama
              CompanyHistory(
                companyName: "Etek Geprek",
                orders: [
                  {
                    "name": "Ayam Geprek",
                    "price": 17000,
                    "date": "11 Des 2024"
                  },
                  {
                    "name": "Es Teh Manis",
                    "price": 5000,
                    "date": "11 Des 2024"
                  },
                ],
                totalPaid: 22000,
                note:
                    "Pesanan sudah diterima dengan baik.", // Menambahkan catatan
              ),
              const SizedBox(height: 16),
              // Riwayat transaksi kedua
              CompanyHistory(
                companyName: "Geprek Nusantara",
                orders: [
                  {
                    "name": "Bakso Spesial",
                    "price": 25000,
                    "date": "10 Des 2024"
                  },
                  {
                    "name": "Jeruk Hangat",
                    "price": 8000,
                    "date": "10 Des 2024"
                  },
                ],
                totalPaid: 33000,
                note:
                    "Pesanan sudah diterima dengan baik.", // Menambahkan catatan
              ),
              const SizedBox(height: 16),
              // Riwayat transaksi ketiga
              CompanyHistory(
                companyName: "Cindo Mato",
                orders: [
                  {
                    "name": "Mie Ayam Komplit",
                    "price": 20000,
                    "date": "9 Des 2024"
                  },
                  {"name": "Air Mineral", "price": 3000, "date": "9 Des 2024"},
                ],
                totalPaid: 23000,
                note:
                    "Pesanan sudah diterima dengan baik.", // Menambahkan catatan
              ),
              const SizedBox(height: 16),
              // Riwayat transaksi keempat
              CompanyHistory(
                companyName: "Oishi",
                orders: [
                  {
                    "name": "Mie Ayam Komplit",
                    "price": 20000,
                    "date": "8 Des 2024"
                  },
                  {"name": "Air Mineral", "price": 3000, "date": "8 Des 2024"},
                ],
                totalPaid: 23000,
                note:
                    "Pesanan sudah diterima dengan baik.", // Menambahkan catatan
              ),
              // Additional content for decoration
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Terima kasih telah menggunakan layanan kami. Jangan ragu untuk berbelanja lagi!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.teal,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(context),
    );
  }

  Widget buildBottomNavBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.teal,
          width: 4, // Ketebalan border
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildBottomNavItem("Beranda", Icons.home, () {
            // Navigasi ke beranda
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }),
          buildBottomNavItem("Riwayat", Icons.history, () {
            // Navigasi ke halaman bantuan
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HistoryScreen()),
            );
            // Bisa ditambahkan navigasi ke halaman lain
          }),
          buildBottomNavItem("akun", Icons.person, () {
            // Navigasi ke halaman riwayat
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          }),
        ],
      ),
    );
  }

  Widget buildBottomNavItem(String label, IconData icon, Function onTap) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 30, color: Colors.teal),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.teal),
          ),
        ],
      ),
    );
  }
}

class CompanyHistory extends StatelessWidget {
  final String companyName;
  final List<Map<String, dynamic>> orders;
  final int totalPaid;
  final String? note;

  const CompanyHistory({
    Key? key,
    required this.companyName,
    required this.orders,
    required this.totalPaid,
    this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.receipt_long, color: Colors.teal, size: 30),
                const SizedBox(width: 8),
                Text(
                  companyName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              children: orders.map((order) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order["name"],
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            order["date"],
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                          if (note != null && note!.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              "Catatan: $note",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        "Rp ${order["price"]}",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const Divider(height: 24, color: Colors.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Dibayar:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rp $totalPaid",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(title),
      ),
      body: Center(
        child: Text(
          "Halaman $title",
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
