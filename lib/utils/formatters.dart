class Formatters {
  static String formatDuration(int minutes) {
    if (minutes < 60) {
      return '${minutes}m';
    }
    final hours = minutes ~/ 60;
    final remainingMins = minutes % 60;
    if (remainingMins == 0) return '${hours}h';
    return '${hours}h ${remainingMins}m';
  }

  static String formatTimer(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    final minsStr = minutes.toString().padLeft(2, '0');
    final secsStr = seconds.toString().padLeft(2, '0');
    return '$minsStr:$secsStr';
  }
}
