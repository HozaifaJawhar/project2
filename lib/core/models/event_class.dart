class Event {
  final String imageUrl;
  final String date;
  final String category;
  final String title;
  final int totalVolunteers;
  final int joinedVolunteers;

  Event({
    required this.imageUrl,
    required this.date,
    required this.category,
    required this.title,
    required this.totalVolunteers,
    required this.joinedVolunteers,
  });
}
