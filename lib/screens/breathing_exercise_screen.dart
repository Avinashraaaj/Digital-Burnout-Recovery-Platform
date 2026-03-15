import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class BreathingExerciseScreen extends StatefulWidget {
  const BreathingExerciseScreen({super.key});

  @override
  State<BreathingExerciseScreen> createState() => _BreathingExerciseScreenState();
}

class _BreathingExerciseScreenState extends State<BreathingExerciseScreen> with SingleTickerProviderStateMixin {
  late AnimationController _breathController;
  late Animation<double> _scaleAnimation;
  Timer? _timer;
  final int _totalSeconds = 120; // 2 min
  int _elapsed = 0;
  bool _isRunning = true;
  int _phaseIndex = 0;
  final _phases = ['Inhale', 'Hold', 'Exhale', 'Hold'];
  final _phaseDurations = [4, 2, 4, 2]; // seconds per phase
  int _phaseTimer = 0;

  @override
  void initState() {
    super.initState();
    _breathController = AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(CurvedAnimation(parent: _breathController, curve: Curves.easeInOut));
    _breathController.repeat(reverse: true);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_isRunning) return;
      setState(() {
        _elapsed++;
        _phaseTimer++;
        if (_phaseTimer >= _phaseDurations[_phaseIndex]) {
          _phaseTimer = 0;
          _phaseIndex = (_phaseIndex + 1) % _phases.length;
        }
        if (_elapsed >= _totalSeconds) {
          _timer?.cancel();
          _isRunning = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _breathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final remaining = _totalSeconds - _elapsed;
    final mins = (remaining ~/ 60).toString().padLeft(2, '0');
    final secs = (remaining % 60).toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        title: Column(
          children: [
            const Text('Breathing Exercise', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.schedule, size: 12, color: AppTheme.primaryColor),
              const SizedBox(width: 4),
              Text('2 MIN SESSION', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppTheme.primaryColor, letterSpacing: 1)),
            ]),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [IconButton(icon: const Icon(Icons.settings), onPressed: () {})],
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Phase text
                Text(_phases[_phaseIndex].toUpperCase(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.primaryColor, letterSpacing: 2)),
                const SizedBox(height: 4),
                Text('Focus on the center of the screen', style: TextStyle(fontSize: 13, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
                const SizedBox(height: 40),
                // Breathing circle
                AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        width: 192, height: 192,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppTheme.primaryColor, AppTheme.primaryColor.withValues(alpha: 0.4)]),
                          boxShadow: [BoxShadow(color: AppTheme.primaryColor.withValues(alpha: 0.2), blurRadius: 40, spreadRadius: 8)],
                        ),
                        child: Center(child: Text(_phases[_phaseIndex], style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold))),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 48),
                // Timer display
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _timerBox(mins, 'MINUTES', isDark),
                    Padding(padding: const EdgeInsets.only(bottom: 24), child: Text(':', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? const Color(0xFF475569) : const Color(0xFFCBD5E1)))),
                    _timerBox(secs, 'SECONDS', isDark),
                  ],
                ),
              ],
            ),
          ),
          // Controls
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(icon: const Icon(Icons.replay_10), iconSize: 32, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569), onPressed: () => setState(() => _elapsed = (_elapsed - 10).clamp(0, _totalSeconds))),
                    const SizedBox(width: 24),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isRunning = !_isRunning;
                          if (_isRunning) { _breathController.repeat(reverse: true); } else { _breathController.stop(); }
                        });
                      },
                      child: Container(
                        width: 72, height: 72,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryColor, boxShadow: [BoxShadow(color: AppTheme.primaryColor.withValues(alpha: 0.3), blurRadius: 16, offset: const Offset(0, 4))]),
                        child: Icon(_isRunning ? Icons.pause : Icons.play_arrow, size: 40, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 24),
                    IconButton(icon: const Icon(Icons.forward_10), iconSize: 32, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569), onPressed: () => setState(() => _elapsed = (_elapsed + 10).clamp(0, _totalSeconds))),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(side: BorderSide(color: AppTheme.primaryColor.withValues(alpha: 0.2), width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    child: Text('End Session Early', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _timerBox(String value, String label, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            width: 72, height: 56,
            decoration: BoxDecoration(color: isDark ? const Color(0xFF1E293B) : Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9))),
            child: Center(child: Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primaryColor))),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
        ],
      ),
    );
  }
}
