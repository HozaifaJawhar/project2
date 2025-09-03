class RegistrationData {
  // Step 1 Data
  String? fullName;
  String? address;
  String? gender = 'male';
  DateTime? birthDate;
  String? imagePath;

  // Step 2 Data
  String? email;
  String? password;
  String? phone;
  String? whatsapp;
  String? facebook;
  String? instagram;

  // Step 3 & 4 Data
  Set<int> selectedSkillIds = {};
  int? selectedDepartmentId;

  // Converts the collected data into a map suitable for the API.
  Map<String, String> toApiJson() {
    return {
      'name': fullName ?? '',
      'address': address ?? '',
      'gender': gender ?? 'male',
      'birth_date': birthDate?.toIso8601String() ?? '',
      'email': email ?? '',
      'password': password ?? '',
      'password_confirmation': password ?? '',
      'mobile_number': phone ?? '',
      'whatsapp_number': whatsapp ?? '',
      'facebook_url': facebook ?? '',
      'instagram_url': instagram ?? '',
      'skills': selectedSkillIds.join(','),
      'departments': selectedDepartmentId?.toString() ?? '',
    };
  }
}
