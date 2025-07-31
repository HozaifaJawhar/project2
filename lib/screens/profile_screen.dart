import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:ammerha_volunteer/core/models/volunteer.dart';
import 'package:ammerha_volunteer/core/models/volunteer_profile.dart';
import 'package:ammerha_volunteer/widgets/profile/profile_header.dart';
import 'package:ammerha_volunteer/widgets/profile/rank_section.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class VolunteerProfileScreen extends StatefulWidget {
  const VolunteerProfileScreen({super.key});

  @override
  State<VolunteerProfileScreen> createState() => _VolunteerProfileScreenState();
}

// Mixin required by the TabController for animations.
class _VolunteerProfileScreenState extends State<VolunteerProfileScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // Mock data for UI design and testing. Will be replaced by API data.
  final VolunteerProfile volunteerProfile = VolunteerProfile(
    name: 'حذيفة ابراهيم جوهر',
    id: '12',
    profileImageUrl: 'assets/images/profile.png',
    opportunitiesCount: 0,
    hoursCount: 0,
    rankTier: RankTier.gold,
    rankName: 'متطوع مبتدئ',
    rankProgress: 0.3, // Represents 30%
    skills: ['التصوير', 'التصميم', 'التدريب', 'جمع التبرعات', 'إدارة المشاريع'],
    completedOpportunities: [
      CompletedOpportunity(
        title: 'تنظيم فعالية اليوم الوطني',
        date: '23-09-2024',
      ),
      CompletedOpportunity(title: 'حملة تشجير ', date: '15-10-2024'),
    ],
    socialLinks: {
      'facebook': 'https://facebook.com/yourprofile',
      'linkedin': 'https://linkedin.com/in/yourprofile',
    },
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          centerTitle: true,
          title: Text(
            'ملفك',
            style: GoogleFonts.almarai(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      ProfileHeaderWidget(
                        name: volunteerProfile.name,
                        id: volunteerProfile.id,
                        imageUrl: volunteerProfile.profileImageUrl,
                      ),
                      _buildStatsSection(),
                      RankSectionWidget(
                        rankName: volunteerProfile.rankName,
                        rankProgress: volunteerProfile.rankProgress,
                        rankTier: volunteerProfile.rankTier,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      controller: _tabController,
                      labelColor: AppColors.primary,
                      unselectedLabelColor: AppColors.greyText,
                      indicatorColor: AppColors.primary,
                      indicatorWeight: 3,
                      tabs: [
                        Tab(
                          child: Text(
                            'الملف الشخصي',
                            style: GoogleFonts.almarai(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'الفرص المنجزة',
                            style: GoogleFonts.almarai(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'التواصل',
                            style: GoogleFonts.almarai(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: _buildSkillsTab(),
                ),
                _buildOpportunitiesTab(),
                _buildSocialTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Builds the statistics section.
  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatCard(
            'الفرص',
            volunteerProfile.opportunitiesCount.toString(),
          ),
          const SizedBox(width: 12),
          _buildStatCard('الساعات', volunteerProfile.hoursCount.toString()),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Expanded(
      child: Card(
        elevation: 0,
        color: Colors.grey.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              Text(
                value,
                style: GoogleFonts.almarai(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: GoogleFonts.almarai(
                  fontSize: 12,
                  color: AppColors.greyText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Builds the rank and progress section.
  Widget _buildRankSection() {
    final percentage = (volunteerProfile.rankProgress * 100).toInt();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 0,
        color: Colors.grey.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/icons/medal3.png', width: 40, height: 40),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'رتبة التطوع',
                        style: GoogleFonts.almarai(
                          color: AppColors.greyText,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        volunteerProfile.rankName,
                        style: GoogleFonts.almarai(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: volunteerProfile.rankProgress,
                backgroundColor: Colors.grey.shade300,
                color: AppColors.primary,
                minHeight: 6,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '$percentage%',
                  style: GoogleFonts.almarai(
                    color: AppColors.greyText,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Builds the skills tab view using a Wrap widget for layout.
  Widget _buildSkillsTab() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: volunteerProfile.skills
          .map(
            (skill) => Chip(
              label: Text(
                skill,
                style: GoogleFonts.almarai(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: AppColors.primary.withOpacity(0.1),
              side: BorderSide.none,
            ),
          )
          .toList(),
    );
  }

  // Builds the completed opportunities tab view using a ListView.
  Widget _buildOpportunitiesTab() {
    return ListView.builder(
      itemCount: volunteerProfile.completedOpportunities.length,
      itemBuilder: (context, index) {
        final opp = volunteerProfile.completedOpportunities[index];
        return ListTile(
          leading: const Icon(
            Icons.check_circle_outline,
            color: AppColors.primary,
          ),
          title: Text(opp.title, style: GoogleFonts.almarai()),
          subtitle: Text(opp.date, style: GoogleFonts.almarai()),
        );
      },
    );
  }

  // Builds the social media links tab view, conditionally showing icons.
  Widget _buildSocialTab() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (volunteerProfile.socialLinks.containsKey('facebook'))
          _buildSocialIcon(
            Icons.facebook,
            volunteerProfile.socialLinks['facebook']!,
          ),
        if (volunteerProfile.socialLinks.containsKey('linkedin'))
          _buildSocialIcon(
            Icons.link,
            volunteerProfile.socialLinks['linkedin']!,
          ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return IconButton(
      icon: Icon(icon, color: AppColors.primary, size: 30),
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
    );
  }
}

// Helper class to make the TabBar sticky during scroll.
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
