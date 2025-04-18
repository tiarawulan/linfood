import 'package:http/http.dart' as http; // Mengimpor package http

class ApiService {
  static Future<bool> daftarUMKM(
      String nama, String alamat, String nomorTelepon) async {
    final response = await http.post(
      // Menggunakan http.post dengan benar
      Uri.parse('https://api.example.com/daftar_umkm'),
      body: {
        'nama': nama,
        'alamat': alamat,
        'nomor_telepon': nomorTelepon,
      },
    );

    return response.statusCode == 200;
  }
}
