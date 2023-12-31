import 'package:flutter/material.dart';

import '../globals/global.dart';
import '../splash_screen/splash_screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String userName = "your Name";
  String userEmail = "your Email";
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //drawer header
          Container(
            height: 165,
            color: Colors.grey,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userModelCurrentInfo != null ? userModelCurrentInfo!.name! : userName,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          userModelCurrentInfo != null ? userModelCurrentInfo!.email! : userEmail,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 12.0,
          ),

          //drawer body
          GestureDetector(
            onTap: () {},
            child: const ListTile(
              leading: Icon(
                Icons.history,
                color: Colors.white54,
              ),
              title: Text(
                "History",
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {},
            child: const ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.white54,
              ),
              title: Text(
                "Visit Profile",
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {},
            child: const ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.white54,
              ),
              title: Text(
                "About",
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              fAuth.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (c) => const SplashScreen()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white54,
              ),
              title: Text(
                "Sign Out",
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
