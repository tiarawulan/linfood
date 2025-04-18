import 'package:flutter/material.dart';

class UMKMCard extends StatelessWidget {
  final String name;
  final String address;
  final int rating;
  final String image;
  final VoidCallback onTap;
  final VoidCallback onOrder;

  const UMKMCard({
    Key? key,
    required this.name,
    required this.address,
    required this.rating,
    required this.image,
    required this.onTap,
    required this.onOrder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Bagian Gambar
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                image,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Bagian Informasi UMKM
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    address,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(
                      rating,
                      (index) => const Icon(Icons.star,
                          size: 16, color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),

            // Tombol Aksi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Tombol Pesan
                TextButton.icon(
                  onPressed: onOrder,
                  icon: const Icon(Icons.message, color: Colors.teal),
                  label: const Text(
                    "Pesan",
                    style: TextStyle(color: Colors.teal),
                  ),
                ),

                // Tombol Detail
                TextButton.icon(
                  onPressed: onTap,
                  icon: const Icon(Icons.info_outline, color: Colors.blue),
                  label: const Text(
                    "Detail",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
