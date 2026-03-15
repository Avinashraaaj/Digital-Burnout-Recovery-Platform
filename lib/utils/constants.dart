class AppConstants {
  static const int defaultFocusTimeMinutes = 25;
  static const int focusBreakTimeMinutes = 5;
  
  static const int targetScreenTimeMinutes = 300; // 5 hours
  static const int maxBurnoutScore = 100;
  static const int maxHealthScore = 100;
  
  // Storage keys
  static const String keyScreenTime = 'screen_time_minutes';
  static const String keyBurnoutScore = 'burnout_score';
  static const String keyHealthScore = 'health_score';
  static const String keyBreakSessionsCount = 'break_sessions_count';
  static const String keyYesterdayScreenTime = 'yesterday_screen_time_minutes';
  static const String keyBreakSessionsList = 'break_sessions_list';
}
