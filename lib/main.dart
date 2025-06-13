import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/item_list_screen.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());  // Keep const here for MyApp, which has const constructor
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});  // Const constructor

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ItemService()),
      ],
      child: MaterialApp(
        title: 'Flutter Items App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const AuthWrapper(),
        routes: {
          '/login': (context) => LoginScreen(),
          '/items': (context) => ItemListScreen(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        if (authService.isAuthenticated) {
          return ItemListScreen();  // NO const here
        } else {
          return LoginScreen();  // NO const here
        }
      },
    );
  }
}
