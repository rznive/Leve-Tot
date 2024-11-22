import 'package:flutter/material.dart';
import 'package:quranconnect/controllers/JuzlistController.dart'; // Import the JuzlistController

class ShowByJuz extends StatelessWidget {
  final int juzNumber; // Receive juzNumber from the previous screen

  const ShowByJuz({super.key, required this.juzNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juz $juzNumber'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: JuzlistController.fetchJuzDataByNumber(
            juzNumber), // Fetch data for the selected Juz
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Gagal memuat daftar surah untuk Juz ini'),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data;
            if (data == null ||
                data['surahs'] == null ||
                data['surahs'].isEmpty) {
              return const Center(
                child: Text('No surahs found for this Juz'),
              );
            }

            final surahs = data['surahs'] as Map<String, dynamic>;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: surahs.length,
              itemBuilder: (context, index) {
                final surahKey =
                    surahs.keys.elementAt(index); // Get surah number (key)
                final surah =
                    surahs[surahKey]; // Get surah details using the key

                // Safely access the properties using null-aware operators
                final name = surah?['name'] ?? 'Unknown';
                final englishName = surah?['englishName'] ?? 'Unknown';
                final numberOfAyahs = surah?['numberOfAyahs'] ?? 0;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$name ($englishName)',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$numberOfAyahs Ayahs',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No data available for this Juz'),
            );
          }
        },
      ),
    );
  }
}
