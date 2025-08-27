import 'package:clean_arch_app/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // делаем приложение только landscape для десктопа/планшета
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(
    ProviderScope(
      child: AdminApp(),
    ),
  );
}

class AdminApp extends ConsumerWidget {
  AdminApp({super.key});
  
  final _router = AdminRouter();
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // тут потом добавим тему из стейта если нужно будет
    final isDarkMode = ref.watch(themeProvider);
    
    return MaterialApp.router(
      title: 'Admin Panel',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: _router.config(),
    );
  }
}

// провайдер для темы
final themeProvider = StateProvider<bool>((ref) => false);