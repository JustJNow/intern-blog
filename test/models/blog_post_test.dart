import 'package:flutter_test/flutter_test.dart';
import 'package:wiki_quest/models/blog_post.dart';

void main() {
  group('BlogPost Model', () {
    test('fromJson creates a valid BlogPost object', () {
      final Map<String, dynamic> json = {
        "id": 1,
        "title": "Test Title",
        "description": "Test Description",
        "image_url": "https://example.com/image.png"
      };

      final post = BlogPost.fromJson(json);

      expect(post.id, 1);
      expect(post.title, "Test Title");
      expect(post.description, "Test Description");
      expect(post.imageUrl, "https://example.com/image.png");
    });
  });
}