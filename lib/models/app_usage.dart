import 'package:flutter/material.dart';

class AppUsage {
  final String appName;
  final String category;
  final int usageMinutes;
  final Color iconColor;
  final IconData iconData;

  AppUsage({
    required this.appName,
    required this.category,
    required this.usageMinutes,
    required this.iconColor,
    required this.iconData,
  });
}
