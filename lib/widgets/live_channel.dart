import 'package:flutter/material.dart';
import 'package:twitch_avisos/models/channel.dart';

Widget liveChannel(Channel channel) {
  return Container(
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 5,
          offset: const Offset(0, 1))
    ]),
    child: Column(children: [
      ////////////////////////////////////////////////
      // -----------> NOMBRE <---------------------///
      ////////////////////////////////////////////////
      Container(
          padding: const EdgeInsets.all(5),
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          child: Text(channel.userName,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center)),
      ////////////////////////////////////////////////
      // -----------> TÍTULO <---------------------///
      ////////////////////////////////////////////////
      Container(
          padding: const EdgeInsets.all(5),
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child: Text(channel.title,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center)),
      ////////////////////////////////////////////////
      /// -----------> JUEGO <---------------------///
      ////////////////////////////////////////////////
      Container(
          padding: const EdgeInsets.all(5),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8)),
          ),
          child: Text(channel.gameName,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent),
              textAlign: TextAlign.center))
    ]),
  );
}
