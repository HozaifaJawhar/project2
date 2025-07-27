import 'package:ammerha_volunteer/core/models/volunteer.dart';

class CompletedOpportunity {
  final String title;
  final String date;
  CompletedOpportunity({required this.title, required this.date});
}

// Represents the detailed profile data for a single volunteer.
class VolunteerProfile {
  final String name;
  final String id;
  final String profileImageUrl;
  final int opportunitiesCount;
  final int hoursCount;
  final RankTier rankTier;
  final String rankName;
  final double rankProgress;
  final List<String> skills;
  final List<CompletedOpportunity> completedOpportunities;
  final Map<String, String> socialLinks;

  VolunteerProfile({
    required this.name,
    required this.id,
    required this.profileImageUrl,
    required this.opportunitiesCount,
    required this.hoursCount,
    required this.rankTier,
    required this.rankName,
    required this.rankProgress,
    required this.skills,
    required this.completedOpportunities,
    required this.socialLinks,
  });
}
