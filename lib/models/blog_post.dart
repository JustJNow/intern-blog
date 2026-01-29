class BlogPost {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  BlogPost({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
    );
  }
}