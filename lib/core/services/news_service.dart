import 'package:ammerha_volunteer/config/constants/url.dart';
import 'package:ammerha_volunteer/core/helper/api.dart';
import 'package:ammerha_volunteer/core/models/news_response.dart';

class NewsService {
  final Api api;
  NewsService(this.api);

  Future<NewsResponse> fetchNews({required String token}) async {
    final url = '${AppString.baseUrl}/user/posts/all';

    try {
      final response = await api.get(url: url, token: token);

      if (response == null || response['data'] == null) {
        throw Exception("فشل بجلب الأخبار: لا توجد بيانات");
      }

      return NewsResponse.fromJson(response);
    } catch (e) {
      print("NewsService error: $e");
      rethrow;
    }
  }
}
