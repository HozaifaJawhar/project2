class NewsResponse {
  final List<NewsModel> data;
  final String message;

  NewsResponse({required this.data, required this.message});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      data: (json['data'] as List).map((e) => NewsModel.fromJson(e)).toList(),
      message: json['message'] ?? "",
    );
  }
}

class NewsModel {
  final int id;
  final String title;
  final String body;
  final String publishDate;
  final CoverImage? coverImage;

  NewsModel({
    required this.id,
    required this.title,
    required this.body,
    required this.publishDate,
    this.coverImage,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      title: json['title'] ?? "",
      body: json['body'] ?? "",
      publishDate: json['publish_date'] ?? "",
      coverImage: json['cover_image'] != null
          ? CoverImage.fromJson(json['cover_image'])
          : null,
    );
  }
  @override
  String toString() {
    return 'NewsModel(id: $id, title: $title, date: $publishDate, image: ${coverImage?.file})';
  }
}

class CoverImage {
  final int id;
  final String file;
  final String extension;

  CoverImage({required this.id, required this.file, required this.extension});

  factory CoverImage.fromJson(Map<String, dynamic> json) {
    return CoverImage(
      id: json['id'],
      file: json['file'],
      extension: json['extension'],
    );
  }
}
