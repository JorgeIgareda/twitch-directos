import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:twitch_avisos/models/channel.dart';

class TwitchAPIService {
  static String clientID = dotenv.env['CLIENT_ID'] ?? '';
  static String secret = dotenv.env['SECRET'] ?? '';

  /// Devuelve el token de acceso a la API
  static Future<String> fetchAppAccessToken() async {
    const baseUrl = 'id.twitch.tv';
    Map<String, String> parameters = {
      'client_id': clientID,
      'client_secret': secret,
      'grant_type': 'client_credentials'
    };
    Map<String, String> headers = {'Accept': 'application/json'};

    Uri uri = Uri.https(baseUrl, '/oauth2/token', parameters);

    http.Response? token;
    try {
      token = await http.post(uri, headers: headers);
      if (token.statusCode == 200) {
        return json.decode(token.body)['access_token'];
      }
      return json.decode(token.body)['message'];
    } catch (e) {
      return json.decode(token!.body)['message'];
    }
  }

  // Valida el token de acceso
  static Future<void> validateToken(String token) async {
    const baseUrl = 'id.twitch.tv';
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    Uri uri = Uri.https(baseUrl, '/oauth2/validate');
    await http.get(uri, headers: headers);
  }

  // Consulta si el canal está en directo
  static Future<List<Channel>> fetchStream(
      List<String> channels, String token) async {
    const baseUrl = 'api.twitch.tv';
    Map<String, List<String>> parameters = {'user_login': channels};
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'client-id': clientID
    };
    Uri uri = Uri.https(baseUrl, '/helix/streams', parameters);
    try {
      final http.Response response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        List<Channel> channels =
            data.map((json) => Channel.fromJson(json)).toList();
        return channels;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      rethrow;
    }
  }
}
