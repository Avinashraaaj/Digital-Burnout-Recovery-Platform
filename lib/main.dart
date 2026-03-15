import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'providers/app_provider.dart';
import 'providers/auth_provider.dart';
import 'services/storage_service.dart';
import 'utils/app_theme.dart';
import 'screens/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase 
  await Supabase.initialize(
    url: 'https://inytzmmjiwcdzffnhelt.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlueXR6bW1qaXdjZHpmZm5oZWx0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM1NjM1NzksImV4cCI6MjA4OTEzOTU3OX0._jndokeQ3l0xHu-hMJQCysxadG9PvhrQnDk10FGL5oM',
  );

  final storageService = StorageService();
  await storageService.init();

  runApp(DigitalDetoxApp(storageService: storageService));
}

class DigitalDetoxApp extends StatelessWidget {
  final StorageService storageService;

  const DigitalDetoxApp({Key? key, required this.storageService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppProvider(storageService),
        ),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Digital Burnout Recovery',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const AuthWrapper(),
      ),
    );
  }
}
