import 'package:choke_check_front/ui/pages/post_page.dart';
import 'package:choke_check_front/ui/pages/profile_page.dart';
import 'package:choke_check_front/ui/pages/tournament_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    PostPage(),
    TournamentPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: Container(
        width: 80,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.blue.shade900,
            shape: const CircleBorder(),
            onPressed: () {},
            child: Icon(
              floatingIcon(),
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: floatingLocation(),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 65,
        color: Colors.blue.shade900,
        notchMargin: 10,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: navigationButtons()),
      ),
    );
  }

  navigationButtons() {
    switch (_selectedIndex) {
      case 0:
        return <Widget>[
          const SizedBox(
            width: 75,
          ),
          IconButton(
            icon: const Icon(
              Icons.emoji_events_rounded,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              _onItemTapped(1);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              _onItemTapped(2);
            },
          ),
        ];
      case 1:
        return <Widget>[
          IconButton(
            icon: const Icon(
              Icons.home_rounded,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              _onItemTapped(0);
            },
          ),
          const SizedBox(
            width: 75,
          ),
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              _onItemTapped(2);
            },
          ),
        ];
      case 2:
        return <Widget>[
          IconButton(
            icon: const Icon(
              Icons.home_rounded,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              _onItemTapped(0);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.emoji_events_rounded,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              _onItemTapped(1);
            },
          ),
          const SizedBox(
            width: 75,
          ),
        ];
    }
  }

  FloatingActionButtonLocation floatingLocation() {
    switch (_selectedIndex) {
      case 0:
        return FloatingActionButtonLocation.startDocked;
      case 1:
        return FloatingActionButtonLocation.centerDocked;
      case 2:
        return FloatingActionButtonLocation.endDocked;
    }
    return FloatingActionButtonLocation.centerDocked;
  }

  IconData floatingIcon() {
    switch (_selectedIndex) {
      case 0:
        return Icons.home_rounded;
      case 1:
        return Icons.emoji_events_rounded;
      case 2:
        return Icons.person;
    }
    return Icons.home_filled;
  }
}
