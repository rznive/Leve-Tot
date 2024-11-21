import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class RandomController {
  static Future<Map<String, String>> fetchRandomVerse() async {
    final randomAyahNumber = Random().nextInt(6236) + 1;
    final apiUrl = "https://api.alquran.cloud/v1/ayah/$randomAyahNumber";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'surahArab': responseData['data']['text'],
          'surahName': responseData['data']['surah']['englishName'],
        };
      }
      return {'surahArab': 'Failed to fetch surahArab', 'surahName': 'Error'};
    } catch (_) {
      return {'surahArab': 'An error occurred', 'surahName': 'Error'};
    }
  }
}
