import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/blog_post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("The Daily Chronicle"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "${DateTime.now()}".split(' ')[0],
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () => authProvider.logout(),
          ),
        ],
      ),
      body: authProvider.isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.black))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemCount: authProvider.posts.length,
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black, 
                  thickness: 1, 
                  height: 40
                ),
                itemBuilder: (context, index) {
                  return NewspaperArticle(post: authProvider.posts[index]);
                },
              ),
            ),
    );
  }
}

class NewspaperArticle extends StatelessWidget {
  final BlogPost post;

  const NewspaperArticle({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Headline
        Text(
          post.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        
        // Sepia Image
        ClipRect(
          child: ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Color(0xFF704214), // Sepia Tone
              BlendMode.overlay,
            ),
            child: ColorFiltered(
              colorFilter: const ColorFilter.matrix(<double>[
                 0.2126, 0.7152, 0.0722, 0, 0,
                 0.2126, 0.7152, 0.0722, 0, 0,
                 0.2126, 0.7152, 0.0722, 0, 0,
                 0,      0,      0,      1, 0,
              ]), // Grayscale first
              child: Image.network(
                post.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Center(child: Icon(Icons.broken_image, size: 50)),
                ),
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 12),
        
        // First Letter Drop Cap effect (Simple version)
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(
                text: post.description.substring(0, 1),
                style: const TextStyle(
                  fontSize: 34, 
                  fontWeight: FontWeight.bold, 
                  fontFamily: 'Playfair Display'
                ),
              ),
              TextSpan(
                text: post.description.substring(1),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 8),
        
        // "Continue Reading" indicator
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "See Page 4...",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}