import 'dart:convert';

import 'package:ammerha_volunteer/config/constants/url.dart';
import 'package:ammerha_volunteer/core/helper/api.dart';
import 'package:ammerha_volunteer/core/models/event.dart';

class EventsService {
  final Api _api;
  EventsService(this._api);

  Future<List<Eventt>> getEvents({String? token}) async {
    final url = '${AppString.baseUrl}/dashboard/events/all';
    final res = await _api.get(url: url, token: token);

    if (res is Map<String, dynamic> && res['data'] is List) {
      final list = (res['data'] as List)
          .whereType<Map<String, dynamic>>()
          .map<Eventt>((e) => Eventt.fromJson(e))
          .toList();
      return list;
    }

    throw Exception('Unexpected response format while fetching events');
  }
   Future<bool> registerVolunteer(int eventId, String token) async {
    final url ='${AppString.baseUrl}/user/events/$eventId/register';

    final response = await _api.post(
      url: url, body: null, token: '',
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["message"] == "Success!";
    } else {
      throw Exception("فشل التسجيل: ${response.statusCode}");
    }
  }
}
