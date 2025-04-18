import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final _client = Supabase.instance.client;

  // Fungsi untuk mengambil data dari Supabase
  Future<List<dynamic>?> fetchData(String table, {Map<String, dynamic>? filters}) async {
    try {
      var query = _client.from(table).select();

      // Apply filter if available
      if (filters != null) {
        filters.forEach((key, value) {
          query = query.eq(key, value);
        });
      }

      final response = await query;

      // Cek jika ada error
      if (response.error != null) {
        print('Error fetching data: ${response.error!.message}');
        return null;
      }

      // Pastikan data berhasil diterima
      return response.data as List<dynamic>;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Fungsi untuk menambahkan data ke Supabase
  Future<void> addData(String table, Map<String, dynamic> data) async {
    try {
      final response = await _client.from(table).insert(data).select();

      // Cek jika ada error
      if (response.error != null) {
        print('Error adding data: ${response.error!.message}');
      } else {
        print('Data berhasil ditambahkan');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Fungsi untuk mengupdate data di Supabase
  Future<void> updateData(String table, Map<String, dynamic> data, int id) async {
    try {
      final response = await _client.from(table).update(data).eq('id', id).select();

      // Cek jika ada error
      if (response.error != null) {
        print('Error updating data: ${response.error!.message}');
      } else {
        print('Data berhasil diperbarui');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Fungsi untuk menghapus data di Supabase
  Future<void> deleteData(String table, int id) async {
    try {
      final response = await _client.from(table).delete().eq('id', id).select();

      // Cek jika ada error
      if (response.error != null) {
        print('Error deleting data: ${response.error!.message}');
      } else {
        print('Data berhasil dihapus');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Fungsi untuk login berdasarkan username dan password
  Future<Map<String, dynamic>?> login(String username, String password) async {
    try {
      final filters = {
        'username': username,
        'password': password,
      };

      final response = await fetchData('umkm_accounts', filters: filters);

      // Cek jika response null atau kosong
      if (response == null || response.isEmpty) {
        print('Username atau password salah');
        return null;
      }

      return response[0]; // Ambil data pengguna pertama jika berhasil
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }
}
