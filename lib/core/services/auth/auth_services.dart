import 'package:ammerha_volunteer/config/constants/url.dart';
import 'package:ammerha_volunteer/core/helper/api.dart';
import 'package:ammerha_volunteer/core/models/register_helper.dart';
import 'package:ammerha_volunteer/core/models/registration_data.dart';

class AuthService {
  final Api _api = Api();

  Future<String> login({
    required String email,
    required String password,
  }) async {
    final data = await _api.post(
      url: '${AppString.baseUrl}/auth/user/login',
      body: {'email': email, 'password': password},
      token: null,
    );

    // تعديل هنا للوصول إلى token داخل data
    final token =
        data['data']?['token']; // ملاحظة: استخدم data['data'] وليس data مباشرة

    if (token != null) {
      return token;
    } else {
      throw Exception(data['message'] ?? 'فشل تسجيل الدخول');
    }
  }

  Future<Map<String, dynamic>> fetchRegistrationOptions() async {
    final responseData = await _api.get(
      url: '${AppString.baseUrl}/register/helper',
      token: null,
    );
    if (responseData['data'] != null) {
      final List<dynamic> departmentsJson = responseData['data']['departments'];
      final List<dynamic> skillsJson = responseData['data']['skills'];
      return {
        'departments': departmentsJson
            .map((e) => Department.fromJson(e))
            .toList(),
        'skills': skillsJson.map((e) => Skill.fromJson(e)).toList(),
      };
    } else {
      throw Exception('Failed to load registration options');
    }
  }

  Future<void> registerVolunteer(RegistrationData registrationData) async {
    // Note: The API helper class handles form-urlencoded content type.
    await _api.post(
      url: '${AppString.baseUrl}/register',
      body: registrationData.toApiJson(),
      token: null,
    );
  }
}
