import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:ammerha_volunteer/core/models/volunteer_api_model.dart';
import 'package:ammerha_volunteer/core/provider/volunteer_provider.dart';
import 'package:ammerha_volunteer/widgets/profile/hours_opportunities.dart';
import 'package:ammerha_volunteer/widgets/profile/profile_header.dart';
import 'package:ammerha_volunteer/widgets/profile/rank_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VolunteerProfileScreen extends StatefulWidget {
  const VolunteerProfileScreen({super.key});

  @override
  State<VolunteerProfileScreen> createState() => _VolunteerProfileScreenState();
}

class _VolunteerProfileScreenState extends State<VolunteerProfileScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    // جلب البيانات عند فتح الشاشة
    Future.microtask(() async {
      final token = await _storage.read(key: 'auth_token');
      if (token != null) {
        await context.read<VolunteerProvider>().fetchVolunteer(token: token);
      }
    });
  }

  Future<void> _refresh() async {
    final token = await _storage.read(key: 'auth_token');
    if (token == null) return;
    await context.read<VolunteerProvider>().fetchVolunteer(token: token);
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
        body: Consumer<VolunteerProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (provider.error != null) {
              return Center(child: Text('خطأ: ${provider.error}'));
            }
            final VolunteerApiModel? profile = provider.profile;
            if (profile == null) {
              return const Center(child: Text('لا توجد بيانات المتطوع'));
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              child: DefaultTabController(
                length: 3,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            ProfileHeaderWidget(
                              name: profile.name,
                              imageUrl: profile.personalImage,
                            ),
                            StatsSectionWidget(
                              opportunitiesCount: profile.events.length,
                              hoursCount: profile.points,
                            ),
                            RankSectionWidget(
                              rankName: profile.rank,
                              rankProgress: profile.progress,
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
                            tabs: const [
                              Tab(text: 'المهارات'),
                              Tab(text: 'الفرص المنجزة'),
                              Tab(text: 'التواصل'),
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
                      profile.skills.isNotEmpty
                          ? SingleChildScrollView(
                              padding: const EdgeInsets.all(16),
                              child: _buildSkillsTab(profile),
                            )
                          : const Center(child: Text("لا توجد مهارات")),
                      profile.events.isNotEmpty
                          ? _buildOpportunitiesTab(profile)
                          : const Center(child: Text("لا توجد فرص منجزة")),
                      _buildSocialTab(profile),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSkillsTab(VolunteerApiModel profile) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: profile.skills
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

  Widget _buildOpportunitiesTab(VolunteerApiModel profile) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: profile.events.length,
      itemBuilder: (context, index) {
        final event = profile.events[index];
        return ListTile(
          leading: const Icon(
            Icons.check_circle_outline,
            color: AppColors.primary,
          ),
          title: Text(event.name, style: GoogleFonts.almarai()),
          subtitle: Text(
            '${event.date?.toLocal().toString().split(' ')[0] ?? ''}',
            style: GoogleFonts.almarai(),
          ),
        );
      },
    );
  }

  Widget _buildSocialTab(VolunteerApiModel profile) {
    final Map<String, String> socialLinks = {
      if (profile.facebook != null && profile.facebook!.isNotEmpty)
        'facebook': profile.facebook!,
      if (profile.linkedIn != null && profile.linkedIn!.isNotEmpty)
        'linkedin': profile.linkedIn!,
      if (profile.instagram != null && profile.instagram!.isNotEmpty)
        'instagram': profile.instagram!,
    };

    if (socialLinks.isEmpty) {
      return const Center(child: Text("لا توجد روابط تواصل"));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: socialLinks.entries.map((entry) {
        IconData icon = FontAwesomeIcons.facebook;
        if (entry.key == 'linkedin') icon = FontAwesomeIcons.linkedin;
        if (entry.key == 'instagram') icon = FontAwesomeIcons.instagram;

        return IconButton(
          icon: Icon(icon, color: AppColors.primary, size: 30),
          onPressed: () async {
            final uri = Uri.parse(entry.value);
            if (await canLaunchUrl(uri)) await launchUrl(uri);
          },
        );
      }).toList(),
    );
  }
}

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
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}
