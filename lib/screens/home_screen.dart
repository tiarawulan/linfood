import 'package:flutter/material.dart';
import 'package:linfood/screens/cindomato_screen.dart';
import 'package:linfood/screens/oishi_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:linfood/screens/etek_geprek_screen.dart';
import 'package:linfood/screens/geprek_nusantara_screen.dart';
import 'package:linfood/screens/HistoryScreen.dart';
import 'package:linfood/screens/ProfileScreen.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Jaini-Regular.ttf',
        ),
        home: Scaffold(
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Header dengan gambar LF dan karakter koki
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 250,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2f8888),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Gambar LF di kiri atas
                          Positioned(
                            left: 20,
                            top: 20,
                            child: Image.asset(
                              "assets/LF.png",
                              width: 60,
                              height: 60,
                            ),
                          ),
                          // Gambar LF di kanan atas
                          Positioned(
                            right: 20,
                            top: 20,
                            child: Image.asset(
                              "assets/LF.png",
                              width: 60,
                              height: 60,
                            ),
                          ),
                        ],
                      ),
                    ),
// Oval putih dan gambar chef di tengah
                    Positioned(
                      top: 70, // Berada di antara hijau dan putih
                      left: MediaQuery.of(context).size.width / 2 - 85,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Oval putih
                          Container(
                            width: 200,
                            height: 200,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                          ),
                          // Gambar chef
                          Image.asset(
                            "assets/chef.png",
                            width: 200,
                            height: 230,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 60), // Mengatur jarak setelah oval

                // List Items
                _buildMenuItem(
                  context: context,
                  title: "Etek Geprek",
                  imagePath: "assets/etek_geprek.png",
                  rating: 5,
                  address: "FQVH+G9G Taluak",
                  latitude: -0.506191,
                  longitude: 100.778460,
                  onTap: () {
                    _navigateToDetail(context, "Etek Geprek");
                  },
                  onOrder: () {
                    _launchWhatsApp(
                      "Halo Etek Geprek, saya ingin memesan makanan dari UMKM Anda.",
                      "6282283505320",
                    );
                  },
                ),
                _buildMenuItem(
                  context: context,
                  title: "Geprek Nusantara",
                  imagePath: "assets/geprek_nusantara.png",
                  rating: 5,
                  address: "FQQH+VW5 Taluak",
                  latitude: -0.5103615,
                  longitude: 100.7798544,
                  onTap: () {
                    _navigateToDetail(context, "Geprek Nusantara");
                  },
                  onOrder: () {
                    _launchWhatsApp(
                      "Halo Geprek Nusantara, saya ingin memesan makanan dari UMKM Anda.",
                      "6289876543210",
                    );
                  },
                ),
                const SizedBox(height: 5),
                _buildMenuItem(
                  context: context,
                  title: "Cindo Mato",
                  imagePath: "assets/cindomato.png",
                  rating: 5,
                  address: "FQVH+G9G Taluak",
                  latitude: -0.506191,
                  longitude: 100.778460,
                  onTap: () {
                    _navigateToDetail(context, "Cindo Mato");
                  },
                  onOrder: () {
                    _launchWhatsApp(
                      "Halo Cindo Mato, saya ingin memesan makanan dari UMKM Anda.",
                      "6282283505320",
                    );
                  },
                ),
                _buildMenuItem(
                  context: context,
                  title: "Oishi",
                  imagePath: "assets/oishi.png",
                  rating: 5,
                  address: "FQQH+VW5 Taluak",
                  latitude: -0.5103615,
                  longitude: 100.7798544,
                  onTap: () {
                    _navigateToDetail(context, "Oishi");
                  },
                  onOrder: () {
                    _launchWhatsApp(
                      "Halo Oishi, saya ingin memesan makanan dari UMKM Anda.",
                      "6289876543210",
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
               
              ],
            ),

          ),
          bottomNavigationBar: buildBottomNavBar(),
 // Use the bottom navigation bar here
    ),
    );}
    }
  
  

Widget buildBottomNavBar() {
  return Builder(
    builder: (BuildContext context) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.teal,
            width: 4,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildBottomNavItem("Beranda", Icons.home, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            }),
            buildBottomNavItem("Riwayat", Icons.history, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HistoryScreen()),
              );
            }),
            buildBottomNavItem("akun", Icons.person, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>  ProfileScreen()),
              );
            }),
          ],
        ),
      );
    },
  );
}



// Tentukan metode untuk membuat item navigasi bawah individual
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
            style: TextStyle(fontSize: 12, color: Colors.teal),
          ),
        ],
      ),
    );
  }

  

  void _navigateToDetail(BuildContext context, String name) {
    // Peta nama ke widget
    final Map<String, Widget Function()> pageRoutes = {
      "Etek Geprek": () => EtekGeprekScreen(),
      "Geprek Nusantara": () => GepreNusantarakScreen(),
      "Cindo Mato": () => CindomatoScreen(),
      "Oishi": () => OishiScreen(),
    };

    if (pageRoutes.containsKey(name)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => pageRoutes[name]!()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Navigasi ke $name'),
            content: const Text('Halaman detail belum tersedia!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Tutup'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _launchWhatsApp(String message, String phone) async {
    final url = 'https://wa.me/$phone?text=${Uri.encodeComponent(message)}';
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String title,
    required String imagePath,
    required int rating,
    required String address,
    required double latitude,
    required double longitude,
    required VoidCallback onTap,
    required VoidCallback onOrder,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.teal,
          width: 6,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    _openMap(latitude, longitude);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 5),
                      Text(
                        address,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: List.generate(
                    rating,
                    (index) =>
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    TextButton(
                      onPressed: onTap,
                      child: const Text('Lihat Menu'),
                    ),
                    const SizedBox(width: 5),
                    TextButton(
                      onPressed: onOrder,
                      child: const Text('Order'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              width: 130,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openMap(double latitude, double longitude) async {
    final url = 'https://www.google.com/maps?q=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open the map.';
    }
  }


