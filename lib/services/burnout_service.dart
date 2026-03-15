import '../models/app_stats.dart';
import '../utils/constants.dart';

class BurnoutService {
  // Simple algorithm to calculate burnout and health scores based on usage
  static AppStats recalculateScores(AppStats currentStats) {
    // Mock algorithm:
    // higher screen time -> higher burnout
    // higher breaks -> lower burnout
    
    double screenTimeFactor = currentStats.screenTimeMinutes / AppConstants.targetScreenTimeMinutes;
    double burnoutCalc = (screenTimeFactor * 40) - (currentStats.breakSessionsCompleted * 2);
    
    // Clamp to 0-100
    int newBurnout = burnoutCalc.toInt();
    if (newBurnout < 0) newBurnout = 0;
    if (newBurnout > 100) newBurnout = 100;
    
    // Health score is inversely proportional
    int newHealth = 100 - (newBurnout ~/ 1.5);
    
    return AppStats(
      screenTimeMinutes: currentStats.screenTimeMinutes,
      burnoutScore: newBurnout,
      healthScore: newHealth,
      breakSessionsCompleted: currentStats.breakSessionsCompleted,
      yesterdayScreenTimeMinutes: currentStats.yesterdayScreenTimeMinutes,
    );
  }
}
