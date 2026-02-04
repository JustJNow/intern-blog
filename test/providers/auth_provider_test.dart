import 'package:flutter_test/flutter_test.dart';
import 'package:wiki_quest/providers/auth_provider.dart';
import 'package:wiki_quest/services/blog_service.dart';
import 'package:wiki_quest/models/blog_post.dart';

class FakeBlogService implements BlogService {
  bool shouldThrowError = false;

  @override
  Future<String> login(String username, String password) async {
    if (shouldThrowError) throw Exception("Login Failed");
    return "valid_test_token";
  }

  @override
  Future<List<BlogPost>> getBlogPosts() async {
    if (shouldThrowError) throw Exception("Fetch Failed");
    return [
      BlogPost(id: 1, title: "A", description: "B", imageUrl: "C")
    ];
  }

  @override
  Future<void> logout() async {
  }
}

void main() {
  late AuthProvider provider;
  late FakeBlogService fakeService;

  setUp(() {
    fakeService = FakeBlogService();
    provider = AuthProvider(fakeService);
  });

  group('AuthProvider Tests', () {
    
    test('Initial state is correct (unauthenticated, empty posts)', () {
      expect(provider.isAuthenticated, false);
      expect(provider.posts, isEmpty);
      expect(provider.isLoading, false);
      expect(provider.errorMessage, null);
    });

    test('Login success updates state to authenticated', () async {
      final success = await provider.login("user", "pass");

      expect(success, true);
      expect(provider.isAuthenticated, true);
      expect(provider.errorMessage, null);
    });

    test('Login failure handles error correctly', () async {
      fakeService.shouldThrowError = true;

      final success = await provider.login("user", "pass");

      expect(success, false);
      expect(provider.isAuthenticated, false);
      expect(provider.errorMessage, contains("Login Failed"));
    });

    test('FetchPosts populates the list on success', () async {
      await provider.login("user", "pass"); 
      
      await provider.fetchPosts();

      expect(provider.posts.length, 1);
      expect(provider.posts.first.title, "A");
      expect(provider.errorMessage, null);
    });

    test('FetchPosts handles errors gracefully', () async {
      await provider.login("user", "pass");
      fakeService.shouldThrowError = true;

      await provider.fetchPosts();

      expect(provider.posts, isEmpty);
      expect(provider.errorMessage, "Failed to load posts");
    });

    test('Logout clears token and posts', () async {
      await provider.login("user", "pass");
      await provider.fetchPosts();
      expect(provider.isAuthenticated, true);

      await provider.logout();

      expect(provider.isAuthenticated, false);
      expect(provider.posts, isEmpty);
    });
  });
}