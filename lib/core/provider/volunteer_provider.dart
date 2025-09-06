import 'package:flutter/foundation.dart';
import 'package:ammerha_volunteer/core/models/volunteer_api_model.dart';
import 'package:ammerha_volunteer/core/services/volunteer_service.dart';

class VolunteerProvider extends ChangeNotifier {
  final VolunteerService _service;

  VolunteerProvider(this._service);

  VolunteerApiModel? _profile;
  VolunteerApiModel? get profile => _profile;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  /// جلب بيانات المتطوع
  Future<void> fetchVolunteer({required String token}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _profile = await _service.fetchVolunteer(token: token);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// تحديث البيانات
  Future<void> refresh({required String token}) async {
    _error = null;
    try {
      _profile = await _service.fetchVolunteer(token: token);
    } catch (e) {
      _error = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
