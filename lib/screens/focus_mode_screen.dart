import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../utils/app_theme.dart';
import '../utils/formatters.dart';
import '../utils/constants.dart';

class FocusModeScreen extends StatelessWidget {
  const FocusModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final isActive = provider.isFocusActive;
    final isPaused = provider.isPaused;
    final remaining = isActive
        ? provider.remainingSeconds
        : AppConstants.defaultFocusTimeMinutes * 60;
    final timerText = Formatters.formatTimer(remaining);
    final progress = isActive
        ? provider.currentFocusSession!.completedSeconds /
            (provider.currentFocusSession!.targetDurationMinutes * 60)
        : 0.0;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Focus Mode',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // Motivational Quote
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Text(
                    'CURRENT SESSION',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '"Stay present, stay focused."',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Timer Ring
            Center(
              child: SizedBox(
                width: 256,
                height: 256,
                child: CustomPaint(
                  painter: _TimerRingPainter(
                    progress: progress,
                    isDark: isDark,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        timerText,
                        style: const TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -2,
                        ),
                      ),
                      Text(
                        'MINUTES REMAINING',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Controls
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              if (!isActive) {
                                provider.startFocusSession(AppConstants.defaultFocusTimeMinutes);
                              } else if (isPaused) {
                                provider.resumeFocusSession();
                              }
                            },
                            icon: Icon(
                              isActive && !isPaused ? Icons.check : Icons.play_arrow,
                              color: Colors.white,
                            ),
                            label: Text(
                              isActive ? (isPaused ? 'Resume' : 'Running') : 'Start',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                              shadowColor: AppTheme.primaryColor.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: isActive && !isPaused
                                ? () => provider.pauseFocusSession()
                                : null,
                            icon: Icon(
                              Icons.pause,
                              color: AppTheme.primaryColor,
                            ),
                            label: Text(
                              'Pause',
                              style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor.withOpacity(0.15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: isActive ? () => provider.stopFocusSession() : null,
                    child: Text(
                      'Stop Session',
                      style: TextStyle(
                        color: isActive
                            ? (isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))
                            : Colors.grey.shade400,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Blocked Apps
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Blocked Apps',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDark ? const Color(0xFFE2E8F0) : const Color(0xFF1E293B),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.danger.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'ACTIVE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.danger,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildBlockedApp(
                    context,
                    icon: Icons.camera_alt,
                    gradient: const [Color(0xFFFBBF24), Color(0xFFEF4444), Color(0xFF9333EA)],
                    name: 'Instagram',
                  ),
                  const SizedBox(height: 12),
                  _buildBlockedApp(
                    context,
                    icon: Icons.close,
                    gradient: const [Color(0xFF1E293B), Color(0xFF0F172A)],
                    name: 'Twitter',
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

  Widget _buildBlockedApp(BuildContext context, {
    required IconData icon,
    required List<Color> gradient,
    required String name,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradient),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text('Restricted', style: TextStyle(fontSize: 12, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
              ],
            ),
          ),
          Icon(Icons.lock, color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8)),
        ],
      ),
    );
  }
}

class _TimerRingPainter extends CustomPainter {
  final double progress;
  final bool isDark;

  _TimerRingPainter({required this.progress, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 10.0;

    // Background ring
    final bgPaint = Paint()
      ..color = AppTheme.primaryColor.withOpacity(0.1)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - strokeWidth / 2, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = AppTheme.primaryColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _TimerRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
