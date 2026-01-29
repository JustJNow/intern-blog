import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/blog_service.dart';
import 'providers/auth_provider.dart';
import 'screens/login.dart';
import 'screens/home.dart';
import 'themes/newspaper_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(MockBlogService()),
        ),
      ],
      child: MaterialApp(
        title: 'Wiki Quest',
        debugShowCheckedModeBanner: false,
        theme: NewspaperTheme.theme,
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    if (authProvider.isAuthenticated) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }
}

