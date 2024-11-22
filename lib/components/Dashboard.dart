import 'package:flutter/material.dart';
import 'package:quranconnect/components/showbyJuz.dart'; // Navigasi ke halaman ShowByJuz
import 'package:quranconnect/controllers/RandomController.dart'; // Mengimpor RandomController

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Last Read dengan FutureBuilder
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Icon(Icons.shuffle, color: Colors.black),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FutureBuilder<Map<String, String>>(
                      future: RandomController.fetchRandomVerse(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text(
                            'Loading...',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Text(
                            'Gagal mengambil ayat',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else if (snapshot.hasData) {
                          final surahArab = snapshot.data!['surahArab']!;
                          final surahName = snapshot.data!['surahName']!;
                          return Text(
                            '$surahArab ($surahName)',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                          );
                        } else {
                          return const Text(
                            'Tidak ada data tersedia',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Bagian Daftar Juz
            const Text(
              'Juz',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) {
                  final juzNumber = index + 1;
                  return ListTile(
                    title: Text('Juz $juzNumber'),
                    trailing: const Icon(Icons.menu_book),
                    onTap: () {
                      // Pass only the juzNumber to the ShowByJuz screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowByJuz(
                              juzNumber: juzNumber), // Passing juzNumber
                        ),
                      );
                    },
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
