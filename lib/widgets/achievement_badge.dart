import 'package:flutter/material.dart';

class AchievementBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isUnlocked;

  const AchievementBadge({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    this.isUnlocked = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Opacity(
      opacity: isUnlocked ? 1.0 : 0.5,
      child: ColorFiltered(
        colorFilter: isUnlocked
            ? const ColorFilter.mode(Colors.transparent, BlendMode.dst)
            : const ColorFilter.mode(Colors.grey, BlendMode.saturation),
        child: SizedBox(
          width: 96,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isUnlocked
                      ? color.withOpacity(isDark ? 0.2 : 0.1)
                      : (isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9)),
                  border: Border.all(
                    color: isUnlocked
                        ? color.withOpacity(0.2)
                        : (isDark ? const Color(0xFF475569) : const Color(0xFFE2E8F0)),
                    width: 2,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: isUnlocked
                      ? color
                      : (isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8)),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
