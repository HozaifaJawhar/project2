class RegistrationData {
  // Step 1
  String? fullName;
  String? address;
  String? gender;
  DateTime? birthDate;
  // TODO: Add image file path

  // Step 2
  String? email;
  String? password;
  String? phone;
  String? whatsapp;
  String? facebook;
  String? instagram;

  // Step 3
  Set<String> skills = {};

  // Step 4
  Set<int> departmentIds = {}; // سنخزن IDs الأقسام المختارة

  Map<String, String> toJson() {
    return {
      'name': fullName ?? '',
      'address': address ?? '',
      'gender': gender ?? '',
      'birth_date': birthDate?.toIso8601String() ?? '',
      'email': email ?? '',
      'password': password ?? '',
      'mobile_number': phone ?? '',
      'whatsapp_number': whatsapp ?? '',
      'facebook': facebook ?? '',
      'instagram': instagram ?? '',
      'skills': skills.join(','),
      'department_ids': departmentIds.join(','),
    };
  }
}
