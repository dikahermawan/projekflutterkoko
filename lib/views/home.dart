import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/views/login.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoggedOut = false;

  Future<void> logout(BuildContext context) async {
    try {
      await _auth.signOut();

      // Logout berhasil
      setState(() {
        _isLoggedOut = true;
      });

      // Lakukan navigasi ke halaman Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      // Terjadi kesalahan saat logout
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Terjadi kesalahan saat logout. Silakan coba lagi.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> property =
        firestore.collection('property');
    final Size screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        if (_isLoggedOut) {
          // Jika sudah logout, biarkan navigasi kembali ke halaman sebelumnya
          return true;
        } else {
          // Jika belum logout, jangan izinkan navigasi kembali
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
              onPressed: () => logout(context),
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    future: property.get(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData) {
                        return Text('No data available');
                      } else {
                        return ListView(
                          children: snapshot.data!.docs.map(
                            (e) => ItemCard(
                              e.data()['name'] as String,
                              e.data()['ket'] as String,
                            ),
                          ).toList(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String name;
  final String ket;

  ItemCard(this.name, this.ket);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text(ket),
      ),
    );
  }
}
