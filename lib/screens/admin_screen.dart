import 'package:flutter/material.dart';
import 'package:linfood/supabase_service.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nomorTelponController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final supabaseService = SupabaseService();
  List<Map<String, dynamic>> pendingAccounts = [];

  @override
  void initState() {
    super.initState();
    _fetchPendingAccounts();
  }

  Future<void> _fetchPendingAccounts() async {
    try {
      final accounts = await supabaseService.fetchData('umkm_accounts');
      if (accounts != null) {
        setState(() {
          pendingAccounts = List<Map<String, dynamic>>.from(accounts);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _addNewAccount() async {
    try {
      await supabaseService.addData('umkm_accounts', {
        'username': _usernameController.text,
        'nomor_telpon': _nomorTelponController.text,
        'alamat': _alamatController.text,
        'password': _passwordController.text,
        'status': 'Pending',
      });
      setState(() {
        pendingAccounts.add({
          'username': _usernameController.text,
          'nomor_telpon': _nomorTelponController.text,
          'alamat': _alamatController.text,
          'password': _passwordController.text,
          'status': 'Pending',
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Akun ${_usernameController.text} berhasil ditambahkan')),
      );
      _usernameController.clear();
      _nomorTelponController.clear();
      _alamatController.clear();
      _passwordController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _approveAccount(int index) async {
    try {
      final account = pendingAccounts[index];
      await supabaseService.updateData(
        'umkm_accounts',
        {'status': 'Approved'},
        account['id'],
      );
      setState(() {
        pendingAccounts[index]['status'] = 'Approved';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${account['username']} approved')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username UMKM',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _nomorTelponController,
                  decoration: InputDecoration(
                    labelText: 'Nomor Telepon',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _alamatController,
                  decoration: InputDecoration(
                    labelText: 'Alamat',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_usernameController.text.isNotEmpty &&
                        _nomorTelponController.text.isNotEmpty &&
                        _alamatController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      _addNewAccount();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Semua kolom wajib diisi')),
                      );
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: pendingAccounts.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(pendingAccounts[index]['username']),
                      subtitle: Text(
                          'Status: ${pendingAccounts[index]['status']}\nNomor Telepon: ${pendingAccounts[index]['nomor_telpon']}\nAlamat: ${pendingAccounts[index]['alamat']}'),
                      trailing: pendingAccounts[index]['status'] == 'Pending'
                          ? ElevatedButton(
                              onPressed: () {
                                _approveAccount(index);
                              },
                              child: Text('Approve'),
                            )
                          : Icon(Icons.check_circle, color: Colors.green),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
