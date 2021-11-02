import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '/views/calls/calls_screen.dart';
import '/constants/constants.dart';
import '/views/profile/profile_screen.dart';
import 'home/home.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _page = 0;

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final widgets = <Widget>[
    Home(),
    const CallsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.call, size: 30),
          Icon(Icons.perm_identity, size: 30),
        ],
        index: 0,
        height: 60.0,
        color: Colors.white,
        key: _bottomNavigationKey,
        letIndexChange:(index)=> true,
        backgroundColor:Palette.kTheme,
        animationCurve: Curves.easeInOut,
        buttonBackgroundColor: Colors.white,
        onTap: (index) => setState(() => _page = index),
        animationDuration: const Duration(milliseconds: 600),
      ),
      body: _buildScreen(widgets, _page),
    );
  }
}

_buildScreen(List<Widget> widgets, int index) => widgets[index];
