import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> register(BuildContext context) async {
    try {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        // Tampilkan pesan error jika email atau password kosong
        return;
      }

      // Membuat akun menggunakan email dan password
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
       
      // Akun berhasil dibuat
      // Lakukan navigasi kembali ke halaman login
      Navigator.pop(context);
    } catch (e) {
      // Terjadi kesalahan saat membuat akun
      // Tampilkan pesan error atau lakukan penanganan kesalahan lainnya
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenSize.height * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Center(
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 2, 45, 119),
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Image.asset(
              "assets/images/welcome.png",
              width: screenSize.width, // Atur lebar gambar
              height: screenSize.height * 0.4, // Atur tinggi gambar
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: screenSize.width * 0.8,
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: screenSize.width * 0.8,
                        child: TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.05),
                      Container(
                        width: screenSize.width * 0.8,
                        height: screenSize.height * 0.072,
                        child: ElevatedButton(
                          onPressed: () {
                            register(context); // Panggil metode register dengan parameter context
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(16),
                            backgroundColor: const Color.fromARGB(255, 2, 45, 119),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Text(
                            'Register',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.05),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.14),
                        child: Container(
                          width: screenSize.width,
                          child: Row(
                            children: [
                              Text('Sudah memiliki akun? '),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context); // Lakukan pop untuk kembali ke halaman login
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 2, 45, 119),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}