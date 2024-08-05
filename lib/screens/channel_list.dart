import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch_avisos/providers/channel_notifier.dart';
import 'package:twitch_avisos/widgets/add_channel.dart';

class ChannelList extends StatelessWidget {
  const ChannelList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChannelNotifier>(
      builder: (context, channelNotifier, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                  child: Container(
                      margin: const EdgeInsets.all(20),
                      width: double.infinity,
                      child: const Text('LISTA DE CANALES',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue)))),
              channelNotifier.channels.isNotEmpty
                  ? ListView.builder(
                      itemCount: channelNotifier.channels.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(channelNotifier.channels[index]),
                              trailing: GestureDetector(
                                  onTap: () =>
                                      channelNotifier.removeChannel(index),
                                  child: const Icon(Icons.delete)),
                            ),
                            index < channelNotifier.channels.length - 1
                                ? const Divider(
                                    color: Colors.black,
                                  )
                                : const SizedBox()
                          ],
                        );
                      })
                  : Container(
                      margin: const EdgeInsets.all(10),
                      child: const Center(
                        child: Text(
                          'No has agregado ningún canal a la lista',
                          style: TextStyle(fontSize: 20),
                        ),
                      )),
              const AddChannel()
            ],
          ),
        );
      },
    );
  }
}
