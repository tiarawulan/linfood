import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package
import 'package:supabase_flutter/supabase_flutter.dart'; // Add Supabase
import 'package:linfood/screens/home_screen.dart';
import 'package:linfood/screens/login_screen.dart';
import 'package:linfood/models/umkm_model.dart'; // Import your UMKMModel

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UMKMModel()), // Provide UMKMModel
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lintau Food',
      theme: ThemeData(
        fontFamily: 'Jaini-Regular',
      ),
      home: const Dasboard(),
    );
  }
}

class Dasboard extends StatelessWidget {
  const Dasboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            // Bagian Header
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
                      Positioned(
                        top: 20,
                        child: Image.asset(
                          "assets/LF.png",
                          width: 80,
                          height: 80,
                        ),
                      ),
                      Positioned(
                        top: 30,
                        left: 20,
                        child: Image.asset(
                          "assets/nasi uduk.png",
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Positioned(
                        top: 30,
                        right: 20,
                        child: Image.asset(
                          "assets/nasi.png",
                          width: 90,
                          height: 90,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 130,
                  left: MediaQuery.of(context).size.width * 0.5 - 100,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
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
                      Image.asset(
                        "assets/chef.png",
                        width: 150,
                        height: 150,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 120),
            const Text(
              "Lintau Food",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Text(
              "Food Delivery",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Memberikan referensi makanan\nTigo Jangko dan Sekitar",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2f8888),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(200, 50),
                elevation: 5,
              ),
              child: const Text(
                "Next",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

