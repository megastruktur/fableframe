import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {

  final int activePage;
  
  const BottomNavBar(
    {Key? key,
    required this.activePage
    }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: activePage,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 20
          ),
          label: 'Home'
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            size: 20,
          ),
          label: 'Profile'
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.plus_one,
            size: 20,
          ),
          label: 'Characters'
        ),
      ],
      onTap: (int idx) {

        if (idx != activePage) {
          switch (idx) {
            case 1:
              Navigator.pushNamed(context, '/profile');
              break;

            case 2:
              Navigator.pushNamed(context, '/characters');
              break;

            case 0:
            default:
              Navigator.pushNamed(context, '/');
              break;

          }
        }
      }
    );
  }
}
