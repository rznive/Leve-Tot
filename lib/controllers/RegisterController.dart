import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterController {
  static Future<String> register(
      String email, String password, String username) async {
    const String apiUrl = "http://103.127.132.23/api/signup/";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'email': email, 'password': password, 'username': username},
      );

      final responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        print("Login Berhasil: ${responseData['message']}");
        return "Login Berhasil: ${responseData['message']}";
      } else {
        print("Login Gagal: ${responseData['error']}");
        return "Login Gagal: ${responseData['error']}";
      }
    } catch (e) {
      print("Terjadi kesalahan pada saat login: $e");
      return "Terjadi kesalahan pada saat login: $e";
    }
  }
}
