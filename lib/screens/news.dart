import 'package:ammerha_volunteer/core/helper/api.dart';
import 'package:ammerha_volunteer/core/provider/news_provider.dart';
import 'package:ammerha_volunteer/core/services/news_service.dart';
import 'package:ammerha_volunteer/widgets/news/news_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'news_details_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? _token;

  Future<void> _ensureFetch(BuildContext context) async {
    _token = await _storage.read(key: 'auth_token');

    final provider = context.read<NewsProvider>();
    if (!provider.isLoading && provider.news.isEmpty && _token != null) {
      await provider.fetchNews(token: _token!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsProvider(NewsService(Api())),
      child: Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _ensureFetch(context);
          });

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: const Color(0xFFF5F5F5),
              body: Consumer<NewsProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.error != null) {
                    return Center(child: Text("خطأ: ${provider.error}"));
                  }

                  if (provider.news.isEmpty) {
                    return const Center(child: Text("لا توجد أخبار حالياً"));
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      if (_token != null) {
                        await provider.refresh(token: _token!);
                      }
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: provider.news.length,
                      itemBuilder: (context, index) {
                        final item = provider.news[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: NewsCard(
                            newsItem: item, // NewsCard يستقبل NewsModel
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      NewsDetailScreen(newsItem: item),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
