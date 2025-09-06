import 'package:ammerha_volunteer/core/models/news_response.dart';
import 'package:ammerha_volunteer/core/services/news_service.dart';
import 'package:flutter/foundation.dart';

class NewsProvider extends ChangeNotifier {
  final NewsService _service;

  NewsProvider(this._service);

  List<NewsModel> _news = [];
  List<NewsModel> get news => _news;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchNews({required String token}) async {
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _service.fetchNews(token: token);
      _news = response.data;
      print(_news);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh({required String token}) async {
    try {
      final response = await _service.fetchNews(token: token);
      _news = response.data;
    } catch (e) {
      _error = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
