import 'package:flutter/material.dart';
import 'package:quranconnect/controllers/LoginController.dart';
import 'package:quranconnect/components/Dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  String _loginMessage = ''; // Variabel untuk menyimpan pesan login

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lorem Ipsum'),
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
              const SizedBox(height: 10),

              // Tombol Sign In
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Logika untuk login dan menampilkan pesan
                      String result = await LoginController.login(
                          emailCtrl.text, passwordCtrl.text);
                      setState(() {
                        _loginMessage = result; // Menyimpan hasil pesan login
                      });

                      // Jika login berhasil, navigasikan ke Dashboard
                      if (result.contains("Berhasil")) {
                        // Navigasi ke halaman Dashboard
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DashboardScreen()),
                        );
                      }
                    },
                    child: const Text("Login"),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Menampilkan pesan login
              if (_loginMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _loginMessage,
                    style: TextStyle(
                      color: _loginMessage.contains("Berhasil")
                          ? Colors.green
                          : Colors.red,
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
