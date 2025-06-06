import 'package:flutter/material.dart';
import 'package:linfood/screens/HistoryScreen.dart';
import 'package:linfood/screens/home_screen.dart' as home;
import 'package:linfood/screens/login_screen.dart' as login;
import 'package:url_launcher/url_launcher.dart';
import 'package:linfood/screens/ProfileScreen.dart';

// Model untuk Menu Item
class MenuItem {
  final String name;
  final String price;
  final String image;
  int quantity;
  String additionalInfo;

  MenuItem({
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 0,
    this.additionalInfo = '',
  });

  int get priceInInt {
    return int.parse(price.replaceAll('k', '')) * 1000;
  }
}

class CindomatoScreen extends StatefulWidget {
  @override
  _CindomatoScreenState createState() => _CindomatoScreenState();
}

class _CindomatoScreenState extends State<CindomatoScreen> {
  String activeCategory = 'Makanan';
  List<MenuItem> selectedItems = [];
  String note = "";

  // Data kategori
  final List<String> categories = [
    'Makanan',
    'Aneka Jus',
    'Teh dan Kopi',
  ];

  // Data rekomendasi
  final List<MenuItem> rekomendasi = [
    MenuItem(
      name: 'Ayam Geprek',
      price: '18k',
      image: 'assets/geprek_komplit_nasi.png',
    ),
    MenuItem(
      name: 'Ayam Penyet',
      price: '18k',
      image: 'assets/3t.png',
    ),
  ];

  // Daftar menu berdasarkan kategori
  final Map<String, List<MenuItem>> menuItems = {
    'Makanan': [
      MenuItem(
        name: 'Ayam Geprek',
        price: '18k',
        image: 'assets/geprek_komplit_nasi.png',
      ),
      MenuItem(
        name: 'Ayam Penyet',
        price: '18k',
        image: 'assets/kampung.png',
      ),
      MenuItem(
        name: 'Pecel Lele',
        price: '18k',
        image: 'assets/lele.png',
      ),
      MenuItem(
        name: 'Mie Nyemek',
        price: '12k',
        image: 'assets/becek.png',
      ),
      MenuItem(
        name: 'Nasi Goreng',
        price: '12k',
        image: 'assets/nasgor.png',
      ),
      MenuItem(
        name: 'MieNas',
        price: '17k',
        image: 'assets/gorget.png',
      ),
      MenuItem(
        name: 'Lele Cabe Ijo',
        price: '18k',
        image: 'assets/lele.png',
      ),
      MenuItem(
        name: 'Soto Babat',
        price: '15k',
        image: 'assets/soto.png',
      ),
    ],
    'Aneka Jus': [
      MenuItem(
        name: 'Jus Alpukat',
        price: '10k',
        image: 'assets/jus_alpukat.png',
      ),
      MenuItem(
        name: 'Jus Mangga',
        price: '10k',
        image: 'assets/jus_mangga.png',
      ),
      MenuItem(
        name: 'Jus Buah Naga',
        price: '10k',
        image: 'assets/naga.png',
      ),
      MenuItem(
        name: 'Jus Jeruk',
        price: '10k',
        image: 'assets/jeruk.png',
      ),
      MenuItem(
        name: 'Jus Tomat',
        price: '10k',
        image: 'assets/tomat.png',
      ),
      MenuItem(
        name: 'Jus Timun',
        price: '10k',
        image: 'assets/timun.png',
      ),
    ],
    'Teh dan Kopi': [
      MenuItem(
        name: 'Teh Telur Tapai',
        price: '12k',
        image: 'assets/tehtelur.png',
      ),
      MenuItem(
        name: 'Teh Telur Original',
        price: '10k',
        image: 'assets/tehtelur.png',
      ),
      MenuItem(
        name: 'Teh Es',
        price: '15k',
        image: 'assets/tehes.png',
      ),
      MenuItem(
        name: 'Teh Manis Panas',
        price: '5k',
        image: 'assets/tehanget.png',
      ),
      MenuItem(
        name: 'Kopi',
        price: '5k',
        image: 'assets/kopi.png',
      ),
      MenuItem(
        name: 'Ginseng',
        price: '10k',
        image: 'assets/ginseng.png',
      ),
    ],
  };

  String _calculateTotal() {
    int total = 0;
    for (var item in selectedItems) {
      total += item.priceInInt * item.quantity;
    }
    return 'Rp ${total.toString()}';
  }

  // Mengirim pesanan ke WhatsApp
  void _orderViaWhatsApp() async {
    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Pilih item terlebih dahulu!")),
      );
      return;
    }

    String orderMessage = "Saya ingin memesan:\n";

    for (var item in selectedItems) {
      if (item.quantity > 0) {
        orderMessage +=
            "${item.name} x${item.quantity} - Rp ${item.priceInInt * item.quantity}\n";
      }
    }

    orderMessage += "Catatan: $note\n";
    orderMessage += "Total: ${_calculateTotal()}";

    final String phoneNumber = "6282283505320"; // Nomor WhatsApp UMKM

    // Tampilkan dialog konfirmasi
    bool confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Konfirmasi Pesanan"),
          content: Text(
            "Apakah Anda yakin ingin mengirim pesanan berikut?\n\n$orderMessage",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Batalkan
              child: Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true), // Lanjutkan
              child: Text("Kirim"),
            ),
          ],
        );
      },
    );

    if (!confirm) return; // Jika pengguna membatalkan, hentikan proses

    final Uri url = Uri.parse(
        "https://wa.me/$phoneNumber?text=${Uri.encodeFull(orderMessage)}");

    try {
      if (await canLaunch(url.toString())) {
        await launch(url.toString());

        // Reset pesanan setelah berhasil dikirim
        setState(() {
          selectedItems.clear(); // Kosongkan daftar pesanan
          for (var category in menuItems.values) {
            for (var item in category) {
              item.quantity = 0; // Reset kuantitas item
            }
          }
          note = ""; // Kosongkan catatan
        });

        // Tampilkan pesan sukses
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Pesanan berhasil dikirim!")),
        );
      } else {
        throw "Tidak dapat membuka WhatsApp";
      }
    } catch (e) {
      // Tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildRecommendationSection(),
            const SizedBox(height: 16),
            _buildCategorySection(),
            const SizedBox(height: 16),
            _buildMenuList(),
            const SizedBox(height: 16),
            _buildTotalSection(),
            const SizedBox(height: 16),
            _buildNoteSection(),
            const SizedBox(height: 16),
            _buildOrderButton(),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(),
    );
  }

// Menambahkan bagian untuk memasukkan catatan pesanan
  Widget _buildNoteSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: (value) {
          setState(() {
            note = value;
          });
        },
        decoration: InputDecoration(
          labelText: 'Catatan (misalnya: tambah pedas)',
          hintText: 'Tulis catatan Anda di sini',
          border: OutlineInputBorder(),
        ),
        maxLines: 3,
      ),
    );
  }

  Widget buildBottomNavBar() {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.teal, width: 4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildBottomNavItem("Beranda", Icons.home, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => home.HomeScreen()),
            );
          }),
          buildBottomNavItem("Riwayat", Icons.history, () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HistoryScreen()),
              );
          }),
          buildBottomNavItem("Akun", Icons.person, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          }),
        ],
      ),
    );
  }

  Widget buildBottomNavItem(String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
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

  Widget _buildHeader() {
    return Stack(
      clipBehavior: Clip.none, // Agar posisi elemen dapat keluar dari Stack
      children: [
        // Background image
        Image.asset(
          'assets/etek_geprek.png',
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.25,
          fit: BoxFit.cover,
        ),
        // Gradient overlay
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.6), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        // Card container
        Positioned(
          bottom: -30, // Posisi keluar dari Stack
          left: MediaQuery.of(context).size.width * 0.05,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.teal,
                width: 4, // Thickness of the border
              ),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    "Cindo Mato",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Address
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: Colors.black54),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "Jl. Selangkai, Nagari Tigo Jangko, Kec. Lintau Buo",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Opening hours
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jam Buka",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "10:00 - 22:00 WIB",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 2),
      ],
    );
  }

  Widget _buildRecommendationSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          const Text(
            'Rekomendasi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: menuItems['Makanan']!.map((menuItem) {
                return Padding(
                  padding: const EdgeInsets.only(
                      right: 8), // Menambahkan jarak antar kartu
                  child: _buildMenuCard(menuItem),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            final isActive = category == activeCategory;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    activeCategory = category;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isActive ? Colors.teal : Colors.teal.shade100,
                  foregroundColor: isActive ? Colors.white : Colors.teal,
                ),
                child: Text(category),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMenuList() {
    final filteredItems = menuItems[activeCategory] ?? [];
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final menuItem = filteredItems[index];
        return _buildDetailedMenuCard(menuItem);
      },
    );
  }

  Widget _buildDetailedMenuCard(MenuItem menuItem) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            menuItem.image,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(menuItem.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle:
            Text(menuItem.price, style: const TextStyle(color: Colors.teal)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'Kurangi jumlah',
              icon: const Icon(Icons.remove_circle_outline, color: Colors.teal),
              onPressed: () {
                setState(() {
                  if (menuItem.quantity > 0) menuItem.quantity--;
                });
              },
            ),
            Text('${menuItem.quantity}'),
            IconButton(
              tooltip: 'Tambah jumlah',
              icon: const Icon(Icons.add_circle_outline, color: Colors.teal),
              onPressed: () {
                setState(() {
                  menuItem.quantity++;
                  if (!selectedItems.contains(menuItem)) {
                    selectedItems.add(menuItem);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(MenuItem menuItem) {
    return Card(
      margin: const EdgeInsets.only(right: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 171,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                menuItem.image,
                width: 171,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(menuItem.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(menuItem.price,
                      style: const TextStyle(color: Colors.teal)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Total', style: TextStyle(fontSize: 18)),
          Text(_calculateTotal(),
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildOrderButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (selectedItems.isNotEmpty) {
            _orderViaWhatsApp(); // Call the function to send the order to WhatsApp
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Pilih item terlebih dahulu!")),
            );
          }
        },
        child: const Text('Pesan Sekarang'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
          backgroundColor: Colors.teal,
        ),
      ),
    );
  }
}


