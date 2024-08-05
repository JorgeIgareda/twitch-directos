import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch_avisos/models/channel.dart';
import 'package:twitch_avisos/providers/channel_notifier.dart';
import 'package:twitch_avisos/widgets/add_channel.dart';
import 'package:twitch_avisos/widgets/live_channel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChannelNotifier>(
      builder: (context, channelNotifier, child) {
        return FutureBuilder<List<Channel>>(
            future: channelNotifier.fetchChannels(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SafeArea(
                          child: Container(
                              margin: const EdgeInsets.all(20),
                              width: double.infinity,
                              child: const Text('CANALES EN DIRECTO',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)))),
                      snapshot.data!.isNotEmpty
                          ? ListView.builder(
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return liveChannel(snapshot.data![index]);
                              })
                          : Container(
                              margin: const EdgeInsets.all(10),
                              child: const Center(
                                child: Text(
                                  'Ningún canal de la lista está en directo',
                                  style: TextStyle(fontSize: 20),
                                ),
                              )),
                      const AddChannel()
                    ],
                  ),
                );
              }
            });
      },
    );
  }
}
