import 'package:clean_arch_app/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [
        ProviderLogger(),
      ],
      child: MyApp(),
    ),
  );
}

class ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    print('${provider.name ?? provider.runtimeType}: $newValue');
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  
  final _appRouter = AppRouter();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Clean Architecture Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}