import 'dart:convert';
import 'package:ammerha_volunteer/config/constants/url.dart';
import 'package:ammerha_volunteer/core/helper/api.dart';
import 'package:ammerha_volunteer/core/models/volunteer_api_model.dart';

class VolunteerService {
  final Api api;
  VolunteerService(this.api);

  /// جلب بيانات المتطوع مباشرة من الـ API
  Future<VolunteerApiModel?> fetchVolunteer({required String token}) async {
    final url = '${AppString.baseUrl}/user/profile';
    try {
      final response = await api.get(url: url, token: token);

      // response الآن Map<String, dynamic>
      if (response.containsKey('data')) {
        final data = response['data'];
        return VolunteerApiModel.fromJson(data);
      } else {
        throw Exception('فشل في جلب بيانات المتطوع: $response');
      }
    } catch (e) {
      print('VolunteerService error: $e');
      throw Exception(e.toString());
    }
  }
}
