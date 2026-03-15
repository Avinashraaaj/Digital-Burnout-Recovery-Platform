import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_stats.dart';
import '../models/break_session.dart';
import '../utils/constants.dart';

class StorageService {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  AppStats getAppStats() {
    return AppStats(
      screenTimeMinutes: _prefs.getInt(AppConstants.keyScreenTime) ?? 135, // Mock default 2h 15m
      burnoutScore: _prefs.getInt(AppConstants.keyBurnoutScore) ?? 24,
      healthScore: _prefs.getInt(AppConstants.keyHealthScore) ?? 88,
      breakSessionsCompleted: _prefs.getInt(AppConstants.keyBreakSessionsCount) ?? 12,
      yesterdayScreenTimeMinutes: _prefs.getInt(AppConstants.keyYesterdayScreenTime) ?? 153, // Mock default ~12% higher
    );
  }

  Future<void> saveAppStats(AppStats stats) async {
    await _prefs.setInt(AppConstants.keyScreenTime, stats.screenTimeMinutes);
    await _prefs.setInt(AppConstants.keyBurnoutScore, stats.burnoutScore);
    await _prefs.setInt(AppConstants.keyHealthScore, stats.healthScore);
    await _prefs.setInt(AppConstants.keyBreakSessionsCount, stats.breakSessionsCompleted);
    await _prefs.setInt(AppConstants.keyYesterdayScreenTime, stats.yesterdayScreenTimeMinutes);
  }

  List<BreakSession> getBreakSessions() {
    final jsonList = _prefs.getStringList(AppConstants.keyBreakSessionsList);
    if (jsonList == null) return [];
    
    return jsonList
        .map((jsonStr) => BreakSession.fromMap(jsonDecode(jsonStr)))
        .toList();
  }

  Future<void> saveBreakSessions(List<BreakSession> sessions) async {
    final jsonList = sessions.map((s) => jsonEncode(s.toMap())).toList();
    await _prefs.setStringList(AppConstants.keyBreakSessionsList, jsonList);
  }
}
