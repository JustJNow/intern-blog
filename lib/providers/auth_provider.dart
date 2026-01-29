import 'package:flutter/material.dart';
import '../services/blog_service.dart';
import '../models/blog_post.dart';

class AuthProvider extends ChangeNotifier {
  final BlogService _blogService;

  AuthProvider(this._blogService);

  String? _token;
  List<BlogPost> _posts = [];
  bool _isLoading = false;
  String? _errorMessage;

  bool get isAuthenticated => _token != null;
  bool get isLoading => _isLoading;
  List<BlogPost> get posts => _posts;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String username, String password) async {
    _setLoading(true);
    try {
      _token = await _blogService.login(username, password);
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    _setLoading(true);
    await _blogService.logout();
    _token = null;
    _posts = [];
    notifyListeners();
    _setLoading(false);
  }

  Future<void> fetchPosts() async {
    if (_token == null) return;
    
    _setLoading(true);
    try {
      _posts = await _blogService.getBlogPosts();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Failed to load posts";
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}