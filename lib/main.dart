import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:twitch_avisos/providers/channel_notifier.dart';
import 'package:twitch_avisos/screens/channel_list.dart';
import 'package:twitch_avisos/screens/home_page.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(ChangeNotifierProvider(
    create: (context) => ChannelNotifier(),
    child: const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentPage = 0;
  final List<Widget> _pages = [const HomePage(), const ChannelList()];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: _pages[_currentPage],
          bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              currentIndex: _currentPage,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.wifi), label: 'Canales en directo'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list), label: 'Lista de canales')
              ]),
        ));
  }
}
