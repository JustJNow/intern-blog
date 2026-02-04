import '/models/blog_post.dart';
abstract class BlogService {
  Future<String> login(String username, String password);
  Future<void> logout();
  Future<List<BlogPost>> getBlogPosts();
}

class MockBlogService implements BlogService {
  
  @override
  Future<String> login(String username, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (username.isNotEmpty && password.isNotEmpty) {
      return "fake_jwt_token_12345";
    } else {
      throw Exception("Invalid credentials");
    }
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<List<BlogPost>> getBlogPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    
    return [
      BlogPost(
        id: 1,
        title: "Unlocking the Secrets of Flutter",
        description: "An insightful post on Flutter best practices.",
        imageUrl: "https://picsum.photos/200/300",
      ),
      BlogPost(
        id: 2,
        title: "Why Architecture Matters",
        description: "Writing clean code is better than writing fast code.",
        imageUrl: "https://picsum.photos/200/301",
      ),
       BlogPost(
        id: 3,
        title: "State Management Wars",
        description: "Provider vs Riverpod vs Bloc.",
        imageUrl: "https://picsum.photos/200/302",
      ),
    ];
  }
}