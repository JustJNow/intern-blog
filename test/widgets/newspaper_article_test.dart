import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wiki_quest/screens/home.dart';
import 'package:wiki_quest/models/blog_post.dart';
import 'package:wiki_quest/themes/newspaper_theme.dart';

void main() {
  testWidgets('NewspaperArticle renders title, image, and description correctly', (WidgetTester tester) async {
    final post = BlogPost(
      id: 1,
      title: "Man Walks on Moon",
      description: "Yesterday, history was made...",
      imageUrl: "https://example.com/moon.jpg",
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: NewspaperTheme.theme,
        home: Scaffold(
          body: NewspaperArticle(
            post: post,
            imageOverride: Image.file(File('test/assets/Panda.jpg')),
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.text("Man Walks on Moon"), findsOneWidget);
    
    expect(find.byType(Image), findsOneWidget);

    expect(find.byWidgetPredicate((widget) {
      if (widget is RichText) {
        return widget.text.toPlainText().contains("Yesterday, history was made");
      }
      return false;
    }), findsOneWidget);

    expect(find.text("See Page 4..."), findsOneWidget);
  });
}