import 'dart:async';
import 'package:flutter/material.dart';
import '../models/app_stats.dart';
import '../models/break_session.dart';
import '../models/focus_session.dart';
import '../services/storage_service.dart';
import '../services/burnout_service.dart';

class AppProvider with ChangeNotifier {
  final StorageService _storageService;
  
  AppStats _stats = AppStats.empty();
  List<BreakSession> _breakSessions = [];
  
  // Focus logic
  FocusSession? _currentFocusSession;
  Timer? _focusTimer;
  bool _isPaused = false;

  bool _isLoading = true;

  AppProvider(this._storageService) {
    _init();
  }

  AppStats get stats => _stats;
  List<BreakSession> get breakSessions => _breakSessions;
  FocusSession? get currentFocusSession => _currentFocusSession;
  bool get isLoading => _isLoading;
  bool get isPaused => _isPaused;
  bool get isFocusActive => _currentFocusSession != null && !_currentFocusSession!.isCompleted;

  int get remainingSeconds {
    if (_currentFocusSession == null) return 0;
    return (_currentFocusSession!.targetDurationMinutes * 60) - _currentFocusSession!.completedSeconds;
  }

  Future<void> _init() async {
    await _storageService.init();
    _stats = _storageService.getAppStats();
    _breakSessions = _storageService.getBreakSessions();
    _isLoading = false;
    notifyListeners();
  }

  void startFocusSession(int durationMinutes) {
    _currentFocusSession = FocusSession(
      targetDurationMinutes: durationMinutes,
      startTime: DateTime.now(),
      isCompleted: false,
      completedSeconds: 0,
    );
    _isPaused = false;
    notifyListeners();
    _startTimer();
  }

  void _startTimer() {
    _focusTimer?.cancel();
    _focusTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentFocusSession != null && !_isPaused) {
        int newSeconds = _currentFocusSession!.completedSeconds + 1;
        if (newSeconds >= _currentFocusSession!.targetDurationMinutes * 60) {
          _completeFocusSession();
        } else {
          _currentFocusSession = FocusSession(
            targetDurationMinutes: _currentFocusSession!.targetDurationMinutes,
            startTime: _currentFocusSession!.startTime,
            isCompleted: false,
            completedSeconds: newSeconds,
          );
          notifyListeners();
        }
      }
    });
  }

  void pauseFocusSession() {
    _isPaused = true;
    _focusTimer?.cancel();
    notifyListeners();
  }

  void resumeFocusSession() {
    _isPaused = false;
    _startTimer();
    notifyListeners();
  }

  void _completeFocusSession() {
    _focusTimer?.cancel();
    _currentFocusSession = FocusSession(
      targetDurationMinutes: _currentFocusSession!.targetDurationMinutes,
      startTime: _currentFocusSession!.startTime,
      isCompleted: true,
      completedSeconds: _currentFocusSession!.completedSeconds,
    );
    notifyListeners();
  }

  void stopFocusSession() {
    _focusTimer?.cancel();
    _currentFocusSession = null;
    _isPaused = false;
    notifyListeners();
  }

  Future<void> logBreak(String activityType, int durationMinutes) async {
    final session = BreakSession(
      activityType: activityType,
      durationMinutes: durationMinutes,
      timestamp: DateTime.now(),
    );
    
    _breakSessions.add(session);
    await _storageService.saveBreakSessions(_breakSessions);
    
    // Update stats
    _stats = AppStats(
      screenTimeMinutes: _stats.screenTimeMinutes,
      burnoutScore: _stats.burnoutScore,
      healthScore: _stats.healthScore,
      breakSessionsCompleted: _stats.breakSessionsCompleted + 1,
      yesterdayScreenTimeMinutes: _stats.yesterdayScreenTimeMinutes,
    );
    
    _stats = BurnoutService.recalculateScores(_stats);
    await _storageService.saveAppStats(_stats);
    
    notifyListeners();
  }
}
