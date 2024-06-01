import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CustomBottomBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Colors.white,
      child: SizedBox(
        height: 56.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              color: selectedIndex == 0 ? Colors.black : Colors.grey,
              onPressed: () => onTabSelected(0),
            ),
            IconButton(
              icon: Icon(Icons.search),
              color: selectedIndex == 1 ? Colors.black : Colors.grey,
              onPressed: () => onTabSelected(1),
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              color: selectedIndex == 2 ? Colors.black : Colors.grey,
              onPressed: () => onTabSelected(2),
            ),
            IconButton(
              icon: Icon(Icons.person),
              color: selectedIndex == 3 ? Colors.black : Colors.grey,
              onPressed: () => onTabSelected(3),
            ),
          ],
        ),
      ),
    );
  }
}
