import 'package:ammerha_volunteer/config/constants/url.dart';
import 'package:ammerha_volunteer/core/helper/api.dart';
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

  Future<void> registerVolunteer(RegistrationData registrationData) async {
    // افترض أن التوكن غير مطلوب لعملية التسجيل
    await _api.post(
      url: '${AppString.baseUrl}/register', // تأكد من المسار
      body: registrationData.toJson(),
      token: null,
    );
  }
}
