class FocusSession {
  final int targetDurationMinutes;
  final DateTime startTime;
  final bool isCompleted;
  final int completedSeconds;

  FocusSession({
    required this.targetDurationMinutes,
    required this.startTime,
    required this.isCompleted,
    required this.completedSeconds,
  });

  Map<String, dynamic> toMap() {
    return {
      'targetDurationMinutes': targetDurationMinutes,
      'startTime': startTime.millisecondsSinceEpoch,
      'isCompleted': isCompleted,
      'completedSeconds': completedSeconds,
    };
  }

  factory FocusSession.fromMap(Map<String, dynamic> map) {
    return FocusSession(
      targetDurationMinutes: map['targetDurationMinutes']?.toInt() ?? 0,
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      isCompleted: map['isCompleted'] ?? false,
      completedSeconds: map['completedSeconds']?.toInt() ?? 0,
    );
  }
}
