import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../widgets/line_chart_widget.dart';
import '../widgets/app_usage_tile.dart';

class ActivityInsightsScreen extends StatefulWidget {
  const ActivityInsightsScreen({Key? key}) : super(key: key);

  @override
  State<ActivityInsightsScreen> createState() => _ActivityInsightsScreenState();
}

class _ActivityInsightsScreenState extends State<ActivityInsightsScreen> {
  int _selectedTab = 1; // 0=Day, 1=Week, 2=Month

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                  ),
                ),
              ),
              child: const Center(
                child: Text(
                  'Activity Insights',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  _buildTab('Day', 0),
                  const SizedBox(width: 32),
                  _buildTab('Week', 1),
                  const SizedBox(width: 32),
                  _buildTab('Month', 2),
                ],
              ),
            ),

            // Weekly Screen Time Card
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Weekly Screen Time',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '5h 42m',
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.danger.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.trending_up, size: 14, color: AppTheme.danger),
                              const SizedBox(width: 4),
                              Text(
                                '12%',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.danger,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const LineChartWidget(
                      values: [4.0, 6.5, 3.5, 5.0, 7.0, 2.5, 8.0],
                      maxY: 10,
                    ),
                  ],
                ),
              ),
            ),

            // Burnout Risk + Usage Type Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Burnout Risk
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Burnout Risk',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Low',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF10B981),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 48,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _buildMiniBar(0.5, isDark),
                                const SizedBox(width: 4),
                                _buildMiniBar(0.75, isDark),
                                const SizedBox(width: 4),
                                _buildMiniBar(0.5, isDark, active: true),
                                const SizedBox(width: 4),
                                _buildMiniBar(0.25, isDark),
                                const SizedBox(width: 4),
                                _buildMiniBar(0.66, isDark),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Usage Type
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Usage Type',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildProgressRow('WORK', 0.65, AppTheme.primaryColor),
                          const SizedBox(height: 12),
                          _buildProgressRow('SOCIAL', 0.35, Colors.orange),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Most Distracting
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.warning_rounded, color: Colors.orange, size: 20),
                  const SizedBox(width: 8),
                  const Text('Most Distracting', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  AppUsageTile(
                    appName: 'Instagram',
                    category: 'Social Media',
                    usageTime: '1h 15m',
                    iconBgColor: Colors.purple,
                    iconContent: const Text('I', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  const SizedBox(height: 12),
                  AppUsageTile(
                    appName: 'X (Twitter)',
                    category: 'Social Media',
                    usageTime: '42m',
                    iconBgColor: Colors.black,
                    iconContent: const Text('X', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Most Productive
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.verified, color: AppTheme.success, size: 20),
                  const SizedBox(width: 8),
                  const Text('Most Productive', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  AppUsageTile(
                    appName: 'Notion',
                    category: 'Productivity',
                    usageTime: '2h 10m',
                    iconBgColor: AppTheme.primaryColor,
                    iconContent: const Icon(Icons.description, color: Colors.white, size: 20),
                  ),
                  const SizedBox(height: 12),
                  AppUsageTile(
                    appName: 'VS Code',
                    category: 'Development',
                    usageTime: '1h 45m',
                    iconBgColor: Colors.blue.shade700,
                    iconContent: const Icon(Icons.terminal, color: Colors.white, size: 20),
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

  Widget _buildTab(String label, int index) {
    final isActive = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.only(bottom: 12, top: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppTheme.primaryColor : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isActive ? AppTheme.primaryColor : const Color(0xFF94A3B8),
          ),
        ),
      ),
    );
  }

  Widget _buildMiniBar(double heightFraction, bool isDark, {bool active = false}) {
    return Expanded(
      child: FractionallySizedBox(
        heightFactor: heightFraction,
        child: Container(
          decoration: BoxDecoration(
            color: active ? AppTheme.primaryColor : AppTheme.primaryColor.withOpacity(0.2),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressRow(String label, double progress, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            Text('${(progress * 100).toInt()}%', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}
