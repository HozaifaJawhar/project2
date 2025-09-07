import 'dart:convert';
import 'package:ammerha_volunteer/config/constants/url.dart';
import 'package:ammerha_volunteer/core/helper/api.dart';
import 'package:ammerha_volunteer/core/models/volunteer_api_model.dart';

class VolunteerService {
  final Api api;
  final String? token;
  VolunteerService(this.api, this.token);

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

  // HonoBoard
  Future<List<VolunteerApiModel>> fetchHonorBoard() async {
    final url = '${AppString.baseUrl}/user/users/honor-board';
    final resp = await api.get(url: url, token: token);

    final List dataList = (resp is List)
        ? resp
        : (resp?['data'] is List ? resp['data'] : const []);

    final list = dataList
        .map<VolunteerApiModel>(
          (e) => VolunteerApiModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();

    // We make sure that the order is in descending order according to points, if the server does not return it in order
    list.sort((a, b) => (b.points ?? 0).compareTo(a.points ?? 0));
    return list;
  }
}
