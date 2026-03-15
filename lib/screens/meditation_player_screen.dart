import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class MeditationPlayerScreen extends StatefulWidget {
  const MeditationPlayerScreen({super.key});

  @override
  State<MeditationPlayerScreen> createState() => _MeditationPlayerScreenState();
}

class _MeditationPlayerScreenState extends State<MeditationPlayerScreen> {
  bool _isPlaying = true;
  int _elapsed = 442; // 7:22 mock
  final int _total = 1200; // 20:00
  double _volume = 0.65;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_isPlaying) return;
      setState(() {
        _elapsed++;
        if (_elapsed >= _total) { _isPlaying = false; _timer?.cancel(); }
      });
    });
  }

  @override
  void dispose() { _timer?.cancel(); super.dispose(); }

  String _fmt(int s) => '${(s ~/ 60).toString().padLeft(2, '0')}:${(s % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = _elapsed / _total;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF101C22) : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _headerBtn(Icons.expand_more, isDark, () => Navigator.pop(context)),
                  Column(children: [
                    Text('NOW PLAYING', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primaryColor, letterSpacing: 2)),
                    const SizedBox(height: 2),
                    Text('Digital Reset', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
                  ]),
                  _headerBtn(Icons.more_horiz, isDark, () {}),
                ],
              ),
            ),
            // Artwork
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 256, height: 256,
                    child: Stack(alignment: Alignment.center, children: [
                      // Progress ring
                      CustomPaint(size: const Size(256, 256), painter: _RingPainter(progress: progress, isDark: isDark)),
                      // Inner circle
                      Container(
                        width: 200, height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppTheme.primaryColor.withValues(alpha: 0.4), const Color(0xFF2DD4BF).withValues(alpha: 0.3)]),
                          boxShadow: [BoxShadow(color: AppTheme.primaryColor.withValues(alpha: 0.15), blurRadius: 24)],
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(36),
                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white.withValues(alpha: 0.3)), color: Colors.white.withValues(alpha: 0.1)),
                          child: const Center(child: Text('Breathe', style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 2, fontWeight: FontWeight.w300))),
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 32),
                  const Text('Deep Focus Unplugged', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('with Dr. Julian Vance', style: TextStyle(fontWeight: FontWeight.w500, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
                  const SizedBox(height: 24),
                  // Time labels
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(_fmt(_elapsed), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppTheme.primaryColor)),
                      Text(_fmt(_total), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
                    ]),
                  ),
                  const SizedBox(height: 24),
                  // Controls
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      IconButton(icon: const Icon(Icons.replay_10), iconSize: 28, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B), onPressed: () => setState(() => _elapsed = (_elapsed - 10).clamp(0, _total))),
                      Row(children: [
                        IconButton(icon: const Icon(Icons.skip_previous), iconSize: 36, color: isDark ? const Color(0xFFE2E8F0) : const Color(0xFF334155), onPressed: () {}),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () => setState(() => _isPlaying = !_isPlaying),
                          child: Container(
                            width: 72, height: 72,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryColor, boxShadow: [BoxShadow(color: AppTheme.primaryColor.withValues(alpha: 0.3), blurRadius: 16, offset: const Offset(0, 4))]),
                            child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, size: 36, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 16),
                        IconButton(icon: const Icon(Icons.skip_next), iconSize: 36, color: isDark ? const Color(0xFFE2E8F0) : const Color(0xFF334155), onPressed: () {}),
                      ]),
                      IconButton(icon: const Icon(Icons.forward_10), iconSize: 28, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B), onPressed: () => setState(() => _elapsed = (_elapsed + 10).clamp(0, _total))),
                    ]),
                  ),
                  const SizedBox(height: 24),
                  // Volume
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(children: [
                      Icon(Icons.volume_mute, size: 16, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                      Expanded(child: SliderTheme(
                        data: SliderThemeData(thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8), trackHeight: 4, activeTrackColor: AppTheme.primaryColor, inactiveTrackColor: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0), thumbColor: Colors.white, overlayShape: SliderComponentShape.noOverlay),
                        child: Slider(value: _volume, onChanged: (v) => setState(() => _volume = v)),
                      )),
                      Icon(Icons.volume_up, size: 16, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                    ]),
                  ),
                ],
              ),
            ),
            // End session
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 24),
              child: SizedBox(
                width: double.infinity, height: 48,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(side: BorderSide(color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: Text('END SESSION', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerBtn(IconData icon, bool isDark, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(shape: BoxShape.circle, color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9)),
        child: Icon(icon, color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569)),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final bool isDark;
  _RingPainter({required this.progress, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2;
    canvas.drawCircle(c, r - 2, Paint()..color = (isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9))..strokeWidth = 4..style = PaintingStyle.stroke);
    canvas.drawArc(Rect.fromCircle(center: c, radius: r - 2), -pi / 2, 2 * pi * progress, false, Paint()..color = AppTheme.primaryColor..strokeWidth = 4..style = PaintingStyle.stroke..strokeCap = StrokeCap.round);
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) => old.progress != progress;
}
