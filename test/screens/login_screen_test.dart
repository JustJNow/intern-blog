import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:wiki_quest/providers/auth_provider.dart';
import 'package:wiki_quest/screens/login.dart';
import 'package:wiki_quest/services/blog_service.dart';
import 'package:wiki_quest/models/blog_post.dart';
import 'package:wiki_quest/themes/newspaper_theme.dart';

class FakeBlogService implements BlogService {
  bool shouldSucceed = true;

  @override
  Future<String> login(String username, String password) async {
    if (shouldSucceed) return "fake_token";
    throw Exception("Invalid credentials");
  }

  @override
  Future<void> logout() async {}
  @override
  Future<List<BlogPost>> getBlogPosts() async => [];
}

void main() {
  late FakeBlogService fakeService;

  setUp(() {
    fakeService = FakeBlogService();
  });

  Widget createLoginScreen() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(fakeService)),
      ],
      child: MaterialApp(
        theme: NewspaperTheme.theme,
        home: const LoginScreen(),
      ),
    );
  }

  testWidgets('Login Screen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createLoginScreen());

    expect(find.text('The Keyturner'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
  });

  testWidgets('Empty fields show validation error', (WidgetTester tester) async {
    await tester.pumpWidget(createLoginScreen());

    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(find.text('Enter username'), findsOneWidget);
    expect(find.text('Enter password'), findsOneWidget);
  });

  testWidgets('Login failure shows error message', (WidgetTester tester) async {
    fakeService.shouldSucceed = false;

    await tester.pumpWidget(createLoginScreen());

    await tester.enterText(find.byType(TextFormField).first, 'user');
    await tester.enterText(find.byType(TextFormField).last, 'pass');

    await tester.tap(find.text('Login'));
    
    await tester.pump(); 
    
    expect(find.text('Exception: Invalid credentials'), findsOneWidget);
  });
}