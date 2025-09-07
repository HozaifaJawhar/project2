import 'package:ammerha_volunteer/core/models/department.dart';
import 'package:ammerha_volunteer/core/models/event.dart';

class VolunteerApiModel {
  final int id;
  final String name;
  final String rank;
  final String progress;
  final String email;
  final String gender;
  final String mobileNumber;
  final String whatsappNumber;
  final String birthDate;
  final String? facebook;
  final String? linkedIn;
  final String? instagram;
  final int points;
  final int active;
  final DepartmentApiModel department;
  final List<String> skills;
  final List<Eventt> events;
  final String? personalImage;

  VolunteerApiModel({
    required this.id,
    required this.name,
    required this.rank,
    required this.progress,
    required this.email,
    required this.gender,
    required this.mobileNumber,
    required this.whatsappNumber,
    required this.birthDate,
    this.facebook,
    this.linkedIn,
    this.instagram,
    required this.points,
    required this.active,
    required this.department,
    required this.skills,
    required this.events,
    this.personalImage,
  });

  factory VolunteerApiModel.fromJson(Map<String, dynamic> json) {
    // id/points/active قد تأتي String
    int _asInt(dynamic v, {int def = 0}) {
      if (v is int) return v;
      return int.tryParse('$v') ?? def;
    }

    List<String> _parseSkills(dynamic v) {
      if (v is List) {
        return v
            .map((e) => e?.toString() ?? '')
            .where((s) => s.isNotEmpty)
            .toList();
      }
      return const <String>[];
    }

    List<Eventt> _parseEvents(dynamic v) {
      if (v is List) {
        return v
            .whereType<Map<String, dynamic>>()
            .map((e) => Eventt.fromJson(e))
            .toList();
      }
      return const <Eventt>[];
    }

    DepartmentApiModel _parseDept(dynamic v) {
      if (v is Map<String, dynamic>) {
        return DepartmentApiModel.fromJson(v);
      }
      return DepartmentApiModel(id: 0, name: '', description: null);
    }

    String? _parseImage(dynamic v) {
      if (v == null) return null;
      if (v is String) {
        final s = v.trim();
        return s.isEmpty ? null : s;
      }
      if (v is Map<String, dynamic>) {
        final f = (v['file'] ?? '').toString().trim();
        if (f.isEmpty) return null;
        final cleaned = f.replaceFirst(RegExp(r'(?<=/)/+'), '/');
        return cleaned;
      }
      return null;
    }

    return VolunteerApiModel(
      id: _asInt(json['id']),
      name: (json['name'] ?? '').toString(),
      rank: (json['rank'] ?? '').toString(),
      progress: (json['progress'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      gender: (json['gender'] ?? '').toString(),
      mobileNumber: (json['mobile_number'] ?? '').toString(),
      whatsappNumber: (json['whatsapp_number'] ?? '').toString(),
      birthDate: (json['birth_date'] ?? '').toString(),
      facebook: (json['facebook'] ?? '').toString().isEmpty
          ? null
          : (json['facebook'] as String),
      linkedIn: (json['linked_in'] ?? '').toString().isEmpty
          ? null
          : (json['linked_in'] as String),
      instagram: (json['instagram'] ?? '').toString().isEmpty
          ? null
          : (json['instagram'] as String),
      points: _asInt(json['points']),
      active: _asInt(json['active']),
      department: _parseDept(json['department']),
      skills: _parseSkills(json['skills']),
      events: _parseEvents(json['events']),
      personalImage: _parseImage(json['personalImage']),
    );
  }
}
