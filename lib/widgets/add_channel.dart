import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch_avisos/providers/channel_notifier.dart';

class AddChannel extends StatefulWidget {
  const AddChannel({super.key});

  @override
  State<AddChannel> createState() => _AddChannelState();
}

class _AddChannelState extends State<AddChannel> {
  final TextEditingController _addChannelController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all()),
              child: TextFormField(
                controller: _addChannelController,
                decoration: const InputDecoration(
                    hintText: 'Escribe el nombre del canal',
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: InputBorder.none),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                final channelNotifier = Provider.of<ChannelNotifier>(context, listen: false);
                channelNotifier.addChannel(_addChannelController.text);
                _addChannelController.clear();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: const Text('AÑADIR', style: TextStyle(fontSize: 20)))
        ],
      ),
    );
  }
}
