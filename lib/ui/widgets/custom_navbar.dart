import 'package:flutter/material.dart';

class CustomBottonNavbar extends StatelessWidget {
  final int? selectedIndex;
  final Function(int index) onTap;

  CustomBottonNavbar({
    this.selectedIndex,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => onTap(0),
            child: Container(
              width: 40,
              height: 32,
              color: Colors.white,
              child: Column(
                children: [
                  Icon(Icons.home_rounded,
                      color: selectedIndex == 0 ? Colors.blue : Colors.grey),
                  SizedBox(height: 3),
                  CircleAvatar(
                      radius: 2,
                      backgroundColor:
                          selectedIndex == 0 ? Colors.blue : Colors.white)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onTap(1),
            child: Container(
              width: 40,
              height: 32,
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 83),
              child: Column(
                children: [
                  Icon(Icons.notifications_rounded,
                      color: selectedIndex == 1 ? Colors.blue : Colors.grey),
                  SizedBox(height: 3),
                  CircleAvatar(
                      radius: 2,
                      backgroundColor:
                          selectedIndex == 1 ? Colors.blue : Colors.white)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onTap(2),
            child: Container(
              width: 40,
              height: 32,
              color: Colors.white,
              child: Column(
                children: [
                  Icon(Icons.person_rounded,
                      color: selectedIndex == 2 ? Colors.blue : Colors.grey),
                  SizedBox(height: 3),
                  CircleAvatar(
                      radius: 2,
                      backgroundColor:
                          selectedIndex == 2 ? Colors.blue : Colors.white)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
