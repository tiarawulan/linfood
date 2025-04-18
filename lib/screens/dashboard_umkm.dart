import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Profil UMKM
  String umkmName = "ayam bakar ldr";
  String umkmEmail = "ldr@gmail.com";
  String umkmPhone = "081234567890";
  String umkmAddress = "Jl.tigo jangko,lintau buo";
  File? umkmImage;

  // Menu List
  final List<Map<String, dynamic>> menuList = [
    {"name": "Nasi Goreng", "price": 20000, "image": null},
    {"name": "Ayam Geprek", "price": 25000, "image": null},
  ];

  final TextEditingController _menuNameController = TextEditingController();
  final TextEditingController _menuPriceController = TextEditingController();
  final TextEditingController _umkmNameController = TextEditingController();
  final TextEditingController _umkmEmailController = TextEditingController();
  final TextEditingController _umkmPhoneController = TextEditingController();
  final TextEditingController _umkmAddressController = TextEditingController();
  File? _menuImage;

  // Pick Image for UMKM Profile
  Future<void> _pickUMKMImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        umkmImage = File(result.files.single.path!);
      });
    }
  }

  // Pick Image for Menu
  Future<void> _pickMenuImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _menuImage = File(result.files.single.path!);
      });
    }
  }

  // Add Menu
  void _addMenu() {
    if (_menuNameController.text.isNotEmpty &&
        _menuPriceController.text.isNotEmpty &&
        _menuImage != null) {
      setState(() {
        menuList.add({
          "name": _menuNameController.text,
          "price": int.tryParse(_menuPriceController.text) ?? 0,
          "image": _menuImage,
        });
      });
      Navigator.pop(context); // Close dialog
      _menuNameController.clear();
      _menuPriceController.clear();
      _menuImage = null;
    }
  }

  // Edit Menu
  void _editMenu(int index) {
    _menuNameController.text = menuList[index]["name"];
    _menuPriceController.text = menuList[index]["price"].toString();
    _menuImage = menuList[index]["image"];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Menu"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _menuNameController,
                decoration: const InputDecoration(labelText: "Nama Menu"),
              ),
              TextField(
                controller: _menuPriceController,
                decoration: const InputDecoration(labelText: "Harga Menu"),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _pickMenuImage,
                icon: const Icon(Icons.image),
                label: const Text("Pilih Gambar Menu"),
              ),
              if (_menuImage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Image.file(
                    _menuImage!,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  menuList[index] = {
                    "name": _menuNameController.text,
                    "price": int.tryParse(_menuPriceController.text) ?? 0,
                    "image": _menuImage,
                  };
                });
                Navigator.pop(context); // Close dialog
                _menuNameController.clear();
                _menuPriceController.clear();
                _menuImage = null;
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  // Delete Menu
  void _deleteMenu(int index) {
    setState(() {
      menuList.removeAt(index);
    });
  }

  // Edit UMKM Profile
  void _editUMKMProfile() {
    _umkmNameController.text = umkmName;
    _umkmEmailController.text = umkmEmail;
    _umkmPhoneController.text = umkmPhone;
    _umkmAddressController.text = umkmAddress;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Profil UMKM"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _umkmNameController,
                decoration: const InputDecoration(labelText: "Nama UMKM"),
              ),
              TextField(
                controller: _umkmEmailController,
                decoration: const InputDecoration(labelText: "Email UMKM"),
              ),
              TextField(
                controller: _umkmPhoneController,
                decoration: const InputDecoration(labelText: "Telepon UMKM"),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: _umkmAddressController,
                decoration: const InputDecoration(labelText: "Alamat UMKM"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  umkmName = _umkmNameController.text;
                  umkmEmail = _umkmEmailController.text;
                  umkmPhone = _umkmPhoneController.text;
                  umkmAddress = _umkmAddressController.text;
                });
                Navigator.pop(context); // Close dialog
              },
              child: const Text("Simpan"),
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
        title: const Text("Dashboard UMKM"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profil UMKM
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickUMKMImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            umkmImage != null ? FileImage(umkmImage!) : null,
                        child: umkmImage == null
                            ? const Icon(Icons.add_a_photo, size: 50)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      umkmName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text("Email: $umkmEmail"),
                    Text("Telepon: $umkmPhone"),
                    Text("Alamat: $umkmAddress"),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _editUMKMProfile,
                      child: const Text("Edit Profil UMKM"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Menu List
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Menu Anda",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ListView.builder(
              itemCount: menuList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final menu = menuList[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: menu["image"] != null
                        ? Image.file(menu["image"], width: 50, height: 50)
                        : const Icon(Icons.fastfood, size: 50),
                    title: Text(menu["name"]),
                    subtitle: Text("Harga: Rp ${menu["price"]}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.black),
                          onPressed: () {
                            _editMenu(index);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.black),
                          onPressed: () {
                            _deleteMenu(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ), 

      // FloatingActionButton for Add Menu
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Tambah Menu"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _menuNameController,
                      decoration: const InputDecoration(labelText: "Nama Menu"),
                    ),
                    TextField(
                      controller: _menuPriceController,
                      decoration: const InputDecoration(labelText: "Harga Menu"),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: _pickMenuImage,
                      icon: const Icon(Icons.image),
                      label: const Text("Pilih Gambar Menu"),
                    ),
                    if (_menuImage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Image.file(
                          _menuImage!,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                    },
                    child: const Text("Batal"),
                  ),
                  ElevatedButton(
                    onPressed: _addMenu,
                    child: const Text("Tambah"),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
