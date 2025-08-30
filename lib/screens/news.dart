import 'package:flutter/material.dart';
import '../widgets/news/news_card.dart';
import '../widgets/news/news_item.dart';
import 'news_details_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int currentIndex = 3;

  // Sample news data
  final List<NewsItem> newsItems = [
    NewsItem(
      id: '1',
      title:
          'انضموا إلينا في رحلة تطوعية إلى بلودان حيث الطبيعة تلتقي بالإلهام',
      imageUrl:
          'assets/images/event_image.jpg',
      date: '22 حزيران 2023',
    ),
    NewsItem(
      id: '2',
      title:
          'انضموا إلينا في رحلة تطوعية إلى بلودان حيث الطبيعة تلتقي بالإلهام',
      imageUrl:
      'assets/images/event_image.jpg',
      date: '22 حزيران 2023',
    ),
    NewsItem(
      id: '3',
      title:
          'انضموا إلينا في رحلة تطوعية إلى بلودان حيث الطبيعة تلتقي بالإلهام',
      imageUrl:
      'assets/images/event_image.jpg',
      date: '22 حزيران 2023',
    ),
    NewsItem(
      id: '4',
      title:
          'انضموا إلينا في رحلة تطوعية إلى بلودان حيث الطبيعة تلتقي بالإلهام',
      imageUrl:
      'assets/images/event_image.jpg',
      date: '22 حزيران 2023',
    ),
    NewsItem(
      id: '5',
      title:
          'انضموا إلينا في رحلة تطوعية إلى بلودان حيث الطبيعة تلتقي بالإلهام',
      imageUrl:
      'assets/images/event_image.jpg',
      date: '22 حزيران 2023',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: RefreshIndicator(
          onRefresh: () async {
            // Simulate refresh
            await Future.delayed(const Duration(seconds: 1));
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: newsItems.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: NewsCard(
                  newsItem: newsItems[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailScreen(
                          newsItem: newsItems[index],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
