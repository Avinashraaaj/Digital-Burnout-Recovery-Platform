import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_provider.dart';
import 'services/storage_service.dart';
import 'utils/app_theme.dart';
import 'screens/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storageService = StorageService();
  await storageService.init();

  runApp(DigitalDetoxApp(storageService: storageService));
}

class DigitalDetoxApp extends StatelessWidget {
  final StorageService storageService;

  const DigitalDetoxApp({super.key, required this.storageService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppProvider(storageService),
        ),
      ],
      child: MaterialApp(
        title: 'Digital Burnout Recovery',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const MainNavigationScreen(),
      ),
    );
  }
}
