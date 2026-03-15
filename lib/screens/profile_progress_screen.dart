import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/weekly_bar_chart.dart';
import '../widgets/achievement_badge.dart';

class ProfileProgressScreen extends StatelessWidget {
  const ProfileProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final provider = context.watch<AppProvider>();
    final stats = provider.stats;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const SizedBox(width: 24), // Spacer to center title
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Profile & Progress',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Profile Section
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Avatar
                  Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.primaryColor.withValues(alpha: 0.1),
                          border: Border.all(
                            color: AppTheme.primaryColor.withValues(alpha: 0.2),
                            width: 4,
                          ),
                        ),
                        child: const Icon(Icons.person, size: 60, color: Color(0xFF94A3B8)),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark ? const Color(0xFF101C22) : const Color(0xFFF6F7F8),
                              width: 4,
                            ),
                          ),
                          child: const Icon(Icons.verified, size: 14, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Alex Johnson',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Digital Wellness Enthusiast',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Member since January 2024',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),

            // Stats Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.4,
                children: [
                  _buildStatCard(
                    context,
                    icon: Icons.screen_lock_portrait,
                    label: 'Screen Time',
                    value: '-15%',
                    detail: 'Vs last month',
                    detailColor: AppTheme.success,
                    detailIcon: Icons.arrow_downward,
                  ),
                  _buildStatCard(
                    context,
                    icon: Icons.timer,
                    label: 'Focus Units',
                    value: '128',
                    detail: '+12% Session rate',
                    detailColor: AppTheme.primaryColor,
                    detailIcon: Icons.trending_up,
                  ),
                  _buildStatCard(
                    context,
                    icon: Icons.local_fire_department,
                    label: 'Break Streak',
                    value: '${stats.breakSessionsCompleted} days',
                    detail: 'Personal Best!',
                    detailColor: AppTheme.warning,
                    detailIcon: Icons.celebration,
                  ),
                  _buildStatCard(
                    context,
                    icon: Icons.emoji_events,
                    label: 'Badges',
                    value: '24',
                    detail: '3 new this week',
                    detailColor: AppTheme.primaryColor,
                    detailIcon: Icons.add_circle,
                  ),
                ],
              ),
            ),

            // Weekly Chart
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.bar_chart, color: AppTheme.primaryColor),
                      const SizedBox(width: 8),
                      const Text(
                        'Digital Wellness Trends',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.05)),
                    ),
                    child: const WeeklyBarChart(
                      values: [40, 60, 35, 80, 95, 50, 25],
                    ),
                  ),
                ],
              ),
            ),

            // Achievement Badges
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Achievements',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'View All',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        AchievementBadge(
                          icon: Icons.bolt,
                          label: 'Focus Master',
                          color: Color(0xFF13A4EC),
                        ),
                        SizedBox(width: 12),
                        AchievementBadge(
                          icon: Icons.park,
                          label: 'Nature Break',
                          color: Color(0xFF10B981),
                        ),
                        SizedBox(width: 12),
                        AchievementBadge(
                          icon: Icons.nightlight_round,
                          label: 'Sleep Guard',
                          color: Color(0xFFF97316),
                        ),
                        SizedBox(width: 12),
                        AchievementBadge(
                          icon: Icons.military_tech,
                          label: '30 Day Streak',
                          color: Color(0xFF94A3B8),
                          isUnlocked: false,
                        ),
                      ],
                    ),
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

  Widget _buildStatCard(BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required String detail,
    required Color detailColor,
    required IconData detailIcon,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(detailIcon, size: 12, color: detailColor),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  detail,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: detailColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
