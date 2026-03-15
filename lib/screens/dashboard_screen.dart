import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../utils/app_theme.dart';
import '../utils/formatters.dart';
import '../utils/constants.dart';
import '../widgets/circular_progress_widget.dart';
import '../widgets/metric_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final stats = provider.stats;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.primaryColor.withValues(alpha: 0.2),
                          border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.1), width: 2),
                          image: const DecorationImage(
                            image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuApA672DuB-ReyqGV-iMnLuefbKLhUWbyJGdJ6-pg2vnTwBW-YZODY4MrwtDO1d-MLHC4eei3vRjwO3FqrpZOV2E7hDnNNONRwve3T0yeM6ai35CuP68ang117Aknxi71k6a64lu8tDB1trQyAiuvKM9RQHJMHD6Ycj9PRgSaTX11Mgq5c4nFFVirBA5bQQUtFJV1NesU0kpwA_PNwzBuxy3aQJhBDyzB6jmTdDW01vFZcgWabv_4WfCZgIMISDjcWyCNO_1qh0kb4'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Good Morning, Alex.',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: -0.5),
                          ),
                          Text(
                            'Great progress today.',
                            style: TextStyle(color: isDark ? AppTheme.textMutedDark : AppTheme.textMutedLight, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark ? const Color(0xFF1E293B) : Colors.white,
                      border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
                    ),
                    child: Icon(Icons.notifications_outlined, color: isDark ? AppTheme.textMutedDark : AppTheme.textMutedLight),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Screen Time Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Screen Time', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '-12% vs yesterday', // Static mock for now
                                style: TextStyle(color: AppTheme.primaryColor, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: CircularProgressWidget(
                            percentage: stats.screenTimeMinutes / AppConstants.targetScreenTimeMinutes,
                            centerText: Formatters.formatDuration(stats.screenTimeMinutes),
                            labelText: 'Daily Average',
                          ),
                        ),
                        const SizedBox(height: 24),
                        Divider(color: isDark ? const Color(0xFF334155) : const Color(0xFFF8FAFC)),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Limit: ${Formatters.formatDuration(AppConstants.targetScreenTimeMinutes)}',
                              style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                            ),
                            Text(
                              '${((stats.screenTimeMinutes / AppConstants.targetScreenTimeMinutes) * 100).toInt()}% Used',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Burnout & Health Grid
                  Row(
                    children: [
                      Expanded(
                        child: MetricCard(
                          icon: Icons.bolt,
                          iconColor: Colors.orange,
                          title: 'Burnout Score',
                          value: '${stats.burnoutScore}',
                          subValue: '/100',
                          subtitle: stats.burnoutScore < 40 ? 'Low Risk Range' : 'Moderate Risk',
                          subtitleColor: stats.burnoutScore < 40 ? AppTheme.success : AppTheme.warning,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: MetricCard(
                          icon: Icons.favorite,
                          iconColor: AppTheme.primaryColor,
                          title: 'Health Score',
                          value: '${stats.healthScore}',
                          subValue: '/100',
                          subtitle: stats.healthScore > 80 ? 'Excellent Condition' : 'Good Condition',
                          subtitleColor: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // App Category Usage Bar
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('App Category Usage', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                        const SizedBox(height: 24),
                        
                        // Bar
                        Container(
                          height: 32,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(flex: 65, child: Container(decoration: const BoxDecoration(color: AppTheme.primaryColor, borderRadius: BorderRadius.horizontal(left: Radius.circular(8))))),
                              Expanded(flex: 25, child: Container(color: isDark ? const Color(0xFF475569) : const Color(0xFFCBD5E1))),
                              Expanded(flex: 10, child: Container(decoration: BoxDecoration(color: isDark ? const Color(0xFF64748B) : const Color(0xFFE2E8F0), borderRadius: const BorderRadius.horizontal(right: Radius.circular(8))))),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Legends
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildLegendItem('Productive', '1h 28m', AppTheme.primaryColor),
                            Container(width: 1, height: 30, color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9)),
                            _buildLegendItem('Entertainment', '34m', isDark ? const Color(0xFF475569) : const Color(0xFFCBD5E1)),
                            Container(width: 1, height: 30, color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9)),
                            _buildLegendItem('Other', '13m', isDark ? const Color(0xFF64748B) : const Color(0xFFE2E8F0)),
                          ],
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text('Key Insights', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                  const SizedBox(height: 12),

                  _buildInsightItem(
                    context,
                    icon: Icons.bedtime,
                    iconBgColor: Colors.blue.withValues(alpha: 0.1),
                    iconColor: Colors.blue,
                    title: 'Sleep Quality',
                    subtitle: 'Based on last night',
                    value: '92%',
                  ),
                  const SizedBox(height: 12),
                  _buildInsightItem(
                    context,
                    icon: Icons.psychology,
                    iconBgColor: Colors.purple.withValues(alpha: 0.1),
                    iconColor: Colors.purple,
                    title: 'Focus Deep Work',
                    subtitle: 'Uninterrupted blocks',
                    value: '4h 12m',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, String value, Color markerColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 8, height: 8, decoration: BoxDecoration(color: markerColor, shape: BoxShape.circle)),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildInsightItem(BuildContext context, {required IconData icon, required Color iconBgColor, required Color iconColor, required String title, required String subtitle, required String value}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
              ],
            ),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
