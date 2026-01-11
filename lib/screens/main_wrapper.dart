import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import your Workouts screen
import 'store_screen.dart'; // Import your new Store screen

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  // The list of screens to switch between
  final List<Widget> _screens = [const HomeScreen(), const StoreScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body shows whichever screen is currently selected
      body: _screens[_currentIndex],

      // --- THE BOTTOM NAVIGATION BAR ---
      // We wrap it in a Container to give it the "Glass" or "Dark Theme" look
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E), // Dark Blue Background
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha: 0.1), // Subtle top border
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: const Color(0xFF1A1A2E), // Match background
          selectedItemColor: const Color(
            0xFF4E54C8,
          ), // Bright Blue for active tab
          unselectedItemColor: Colors.grey, // Grey for inactive
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0, // Remove shadow for flat look
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: "Workouts",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: "Store",
            ),
          ],
        ),
      ),
    );
  }
}
