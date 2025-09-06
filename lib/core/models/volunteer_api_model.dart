import 'package:ammerha_volunteer/core/models/event.dart';

class VolunteerApiModel {
  final int id;
  final String name;
  final String rank; // مثل: "المتطوع البرونزي"
  final String progress; // مثل: "0.0%"
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
    return VolunteerApiModel(
      id: json['id'],
      name: json['name'],
      rank: json['rank'],
      progress: json['progress'],
      email: json['email'],
      gender: json['gender'],
      mobileNumber: json['mobile_number'],
      whatsappNumber: json['whatsapp_number'],
      birthDate: json['birth_date'],
      facebook: json['facebook'],
      linkedIn: json['linked_in'],
      instagram: json['instagram'],
      points: json['points'],
      active: json['active'],
      department: DepartmentApiModel.fromJson(json['department']),
      skills: List<String>.from(json['skills']),
      events: (json['events'] as List).map((e) => Eventt.fromJson(e)).toList(),
      personalImage: json['personalImage'],
    );
  }
}

class DepartmentApiModel {
  final int id;
  final String name;
  final String? description;

  DepartmentApiModel({required this.id, required this.name, this.description});

  factory DepartmentApiModel.fromJson(Map<String, dynamic> json) {
    return DepartmentApiModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
