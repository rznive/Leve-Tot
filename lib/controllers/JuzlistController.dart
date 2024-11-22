import 'dart:convert';
import 'package:http/http.dart' as http;

class JuzlistController {
  // Fetch data for a specific Juz
  static Future<Map<String, dynamic>> fetchJuzDataByNumber(
      int juzNumber) async {
    final apiUrl = "https://api.alquran.cloud/v1/juz/$juzNumber";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['data'] ??
            {}; // Return data or empty map if not found
      } else {
        throw Exception('Failed to load Juz data');
      }
    } catch (_) {
      return {}; // Return an empty map in case of error
    }
  }
}
