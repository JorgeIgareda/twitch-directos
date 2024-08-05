import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitch_avisos/models/channel.dart';
import 'package:twitch_avisos/services/twitch_api_service.dart';

class ChannelNotifier extends ChangeNotifier {
  List<String> _channels = [];

  List<String> get channels => _channels;

  ChannelNotifier() {
    fetchChannels();
  }

  Future<List<Channel>> fetchChannels() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _channels = prefs.getStringList('channels') ?? [];
    if (_channels.isNotEmpty) {
      String token = await TwitchAPIService.fetchAppAccessToken();
      return await TwitchAPIService.fetchStream(_channels, token);
    }
    return [];
  }

  Future<void> addChannel(String channel) async {
    if (_channels.contains(channel)) {
      Fluttertoast.showToast(msg: 'El canal $channel ya estaba en la lista.');
    } else if (_channels.length == 100) {
      Fluttertoast.showToast(msg: 'La lista no puede contener más de 100 canales.');
    } else {
      _channels.add(channel);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('channels', _channels);
      notifyListeners();
      Fluttertoast.showToast(
          msg: 'Canal $channel añadido correctamente a la lista.');
    }
  }

  Future<void> removeChannel(int index) async {
    _channels.removeAt(index);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('channels', _channels);
    notifyListeners();
  }
}
