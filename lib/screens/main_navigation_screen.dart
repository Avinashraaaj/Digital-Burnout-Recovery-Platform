import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

// Stand-in for all actual screens, to be built out later
import 'dashboard_screen.dart';
import 'activity_insights_screen.dart';
import 'focus_mode_screen.dart';
import 'recovery_hub_screen.dart';
import 'profile_progress_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const ActivityInsightsScreen(),
    const FocusModeScreen(),
    const RecoveryHubScreen(),
    const ProfileProgressScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).cardTheme.color,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textMutedDark,
        selectedLabelStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights),
            label: 'Activity',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Focus'),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco), // Self improvement
            label: 'Recovery',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
