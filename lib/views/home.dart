import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/views/input_data.dart';
import 'package:project/views/login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _logout() async {
    try {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      // Tangani kesalahan yang terjadi saat logout
      print('Error during logout: $e');
    }
  }

  void _addProperty() {
    print(
      "halo"
    );
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddData()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
            padding: EdgeInsets.only(bottom: 16.0, right: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Tooltip(
                  message: 'Logout',
                  child: FloatingActionButton(
                    heroTag: "addData",
                    onPressed: _addProperty,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.add),
                    tooltip: 'Tambah Property',
                  ),
                ),
                const SizedBox(height: 16.0),
                Tooltip(
                  message: 'Logout',
                  child: FloatingActionButton(
                    heroTag: "Logout",
                    onPressed: () {
                      _logout(); // Panggil fungsi logout saat tombol Logout ditekan
                    },
                    backgroundColor: Colors.red,
                    child: Icon(Icons.logout),
                  ),
                ),
              ],
            )),
      ),
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                _logout(); // Panggil fungsi logout saat opsi logout dipilih
              } else if (value == 'addProperty') {
                // Aksi saat opsi tambah property dipilih
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'addProperty',
                child: Text('Tambah Property'),
              ),
              PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          PropertyCard(
            title: 'Property 1',
            price: 'Rp 1.000.000.000',
            location: 'Jakarta, Indonesia',
            imageUrl:
                'https://media.dekoruma.com/dekohouse/secondary/unit-type/LX-864535741/Rumah_JakartaTimur_1.jpg',
          ),
          SizedBox(height: 16.0),
          PropertyCard(
            title: 'Property 2',
            price: 'Rp 2.500.000.000',
            location: 'Surabaya, Indonesia',
            imageUrl:
                'https://media.dekoruma.com/dekohouse/secondary/unit-type/LX-864535741/Rumah_JakartaTimur_1.jpg',
          ),
          SizedBox(height: 16.0),
          PropertyCard(
            title: 'Property 2',
            price: 'Rp 2.500.000.000',
            location: 'Surabaya, Indonesia',
            imageUrl:
                'https://media.dekoruma.com/dekohouse/secondary/unit-type/LX-864535741/Rumah_JakartaTimur_1.jpg',
          ),
          SizedBox(height: 16.0),
          PropertyCard(
            title: 'Property 2',
            price: 'Rp 2.500.000.000',
            location: 'Surabaya, Indonesia',
            imageUrl:
                'https://media.dekoruma.com/dekohouse/secondary/unit-type/LX-864535741/Rumah_JakartaTimur_1.jpg',
          ),
        ],
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  final String title;
  final String price;
  final String location;
  final String imageUrl;

  PropertyCard({
    required this.title,
    required this.price,
    required this.location,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(8.0),
            ),
            child: Image.network(
              imageUrl,
              height: 150.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
