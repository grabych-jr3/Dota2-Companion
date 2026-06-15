import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hero_model.dart';

class ApiService {
  static const String _baseUrl = 'https://api.opendota.com/api';

  static Future<List<HeroModel>> fetchHeroes() async {
    final response = await http.get(Uri.parse('$_baseUrl/heroStats'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      return body
          .map((dynamic item) => HeroModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load heroes data');
    }
  }
}