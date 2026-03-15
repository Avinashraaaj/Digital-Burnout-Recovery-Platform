import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import 'breathing_exercise_screen.dart';
import 'meditation_player_screen.dart';
import 'break_completion_screen.dart';

class RecoveryHubScreen extends StatelessWidget {
  const RecoveryHubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'Recovery Hub',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Digital Reset',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -0.5),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose a way to recharge.',
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Activity Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildActivityCard(
                    context,
                    icon: Icons.air,
                    title: 'Breathing',
                    subtitle: '2 min session',
                    buttonText: 'Start Session',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const BreathingExerciseScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildActivityCard(
                    context,
                    icon: Icons.self_improvement,
                    title: 'Meditation',
                    subtitle: '5 min mindfulness',
                    buttonText: 'Start Now',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const MeditationPlayerScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildActivityCard(
                    context,
                    icon: Icons.visibility,
                    title: 'Eye Relaxation',
                    subtitle: '20-20-20 Rule',
                    buttonText: 'Begin Drill',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const BreakCompletionScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildActivityCard(
                    context,
                    icon: Icons.directions_walk,
                    title: 'Short Walk',
                    subtitle: '10 min movement',
                    buttonText: 'Go Outside',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const BreakCompletionScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: AppTheme.primaryColor),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: Text(
                      buttonText,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 40, color: AppTheme.primaryColor.withOpacity(0.3)),
          ),
        ],
      ),
    );
  }
}
