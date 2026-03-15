import 'package:flutter_test/flutter_test.dart';
import 'package:digital_detox/main.dart';
import 'package:digital_detox/services/storage_service.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    final storageService = StorageService();
    await storageService.init();
    await tester.pumpWidget(DigitalDetoxApp(storageService: storageService));
    await tester.pumpAndSettle();

    // Verify dashboard loads with expected text
    expect(find.text('Dashboard'), findsWidgets);
  });
}
