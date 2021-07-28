import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'dart:convert';
import 'package:MASK/models/model.dart';

enum Environment { local, develop }

extension EnvironmentURL on Environment {
  String get url {
    switch (this) {
      case Environment.local: return "http://localhost:3000/api/v1/";
      case Environment.develop: return "https://cecbespin.com:3000/api/v1/";
    }
  }

  String get authURL {
    switch (this) {
      case Environment.local: return "http://keycloak:8080/";
      case Environment.develop: return "https://cecbespin.com:8080";
    }
  }
}

class API {
  static final env = Environment.local;

  static http.Client client = IOClient();

  static String accessToken = '';
  static String refreshToken = '';

  static int userID = 6;

  static Future<Tasks> getTasks() async {
    final url = env.url + "tasks";
    final res = await client.get(url, headers: {"Content-Type": "application/json", "Authorization": "Bearer $accessToken"});
    if (res.statusCode == 200) {
      return Tasks.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to fetch tasks');
    }
  }
}
