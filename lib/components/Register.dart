import 'package:flutter/material.dart';
import 'package:quranconnect/controllers/RegisterController.dart';
import 'package:quranconnect/components/Login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController usernameCtrl = TextEditingController();
  String _registerMessage = ''; // Variabel untuk menyimpan pesan pendaftaran

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      backgroundColor: const Color(0xFFEBEBEB),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // TextField untuk Email
              Container(
                width: 300,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: emailCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Insert Email",
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // TextField untuk Password
              Container(
                width: 300,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: passwordCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Insert Password",
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // TextField untuk Username
              Container(
                width: 300,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: usernameCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Insert Username",
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Tombol Register
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (emailCtrl.text.isEmpty ||
                          passwordCtrl.text.isEmpty ||
                          usernameCtrl.text.isEmpty) {
                        setState(() {
                          _registerMessage =
                              "Email dan Password tidak boleh kosong!";
                        });
                        return;
                      }
                      // Logika untuk pendaftaran
                      String result = await RegisterController.register(
                          emailCtrl.text, passwordCtrl.text, usernameCtrl.text);
                      setState(() {
                        _registerMessage =
                            result; // Menyimpan hasil pesan pendaftaran
                      });

                      // Jika pendaftaran berhasil, navigasikan ke Login
                      if (result.contains("Berhasil")) {
                        await Future.delayed(const Duration(seconds: 3));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      }
                    },
                    child: const Text("Register"),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Menampilkan pesan pendaftaran
              if (_registerMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _registerMessage,
                    style: TextStyle(
                      color: _registerMessage.contains("Berhasil")
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              // Tautan kembali ke halaman login
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text(
                  "Sudah punya akun? Login di sini",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
