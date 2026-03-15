import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../utils/app_theme.dart';

class BreakCompletionScreen extends StatefulWidget {
  const BreakCompletionScreen({super.key});

  @override
  State<BreakCompletionScreen> createState() => _BreakCompletionScreenState();
}

class _BreakCompletionScreenState extends State<BreakCompletionScreen> {
  String? _selectedActivity;

  final _activities = [
    {'name': 'Breathing', 'icon': Icons.air},
    {'name': 'Reading', 'icon': Icons.menu_book},
    {'name': 'Studying', 'icon': Icons.school},
    {'name': 'Walking', 'icon': Icons.directions_walk},
    {'name': 'Stretching', 'icon': Icons.accessibility_new},
    {'name': 'Meditation', 'icon': Icons.self_improvement},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        title: const Text('Break Completed', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Container(
                    width: 80, height: 80,
                    decoration: BoxDecoration(color: AppTheme.primaryColor.withValues(alpha: 0.1), shape: BoxShape.circle),
                    child: Icon(Icons.check_circle, size: 40, color: AppTheme.primaryColor),
                  ),
                  const SizedBox(height: 24),
                  const Text('Great job!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('How did you spend your break?', style: TextStyle(fontSize: 16, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
                  const SizedBox(height: 32),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 1.2),
                    itemCount: _activities.length,
                    itemBuilder: (context, i) {
                      final a = _activities[i];
                      final sel = _selectedActivity == a['name'];
                      return GestureDetector(
                        onTap: () => setState(() => _selectedActivity = a['name'] as String),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E293B) : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: sel ? AppTheme.primaryColor : AppTheme.primaryColor.withValues(alpha: 0.1), width: sel ? 2 : 1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 48, height: 48,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: sel ? AppTheme.primaryColor.withValues(alpha: 0.2) : AppTheme.primaryColor.withValues(alpha: 0.05)),
                                child: Icon(a['icon'] as IconData, color: AppTheme.primaryColor),
                              ),
                              const SizedBox(height: 12),
                              Text(a['name'] as String, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: sel ? AppTheme.primaryColor : null)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity, height: 56,
                  child: ElevatedButton(
                    onPressed: _selectedActivity != null ? () {
                      context.read<AppProvider>().logBreak(_selectedActivity!, 5);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Break logged: $_selectedActivity'), backgroundColor: AppTheme.primaryColor));
                    } : null,
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), disabledBackgroundColor: AppTheme.primaryColor.withValues(alpha: 0.3)),
                    child: const Text('Log Break', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                TextButton(onPressed: () => Navigator.pop(context), child: Text('Skip for now', style: TextStyle(color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
