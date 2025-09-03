import 'package:ammerha_volunteer/core/services/auth_services.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;
  String? _token;

  // Getters for UI to access the state
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get token => _token;

  // Main login method
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _token = await _authService.login(email: email, password: password);
      _isLoading = false;
      notifyListeners();
      return true;
    } on Exception catch (e) {
      if (e.toString().contains("auth.wrong_credentials")) {
        _errorMessage = " كلمة المرور خاطئة";
      } else if (e.toString().contains("The selected email is invalid.")) {
        _errorMessage = "البريد الإلكتروني  خاطئ";
      } else {
        _errorMessage = "لم يتم تسجيل الدخول. الرجاء المحاولة مرة أخرى";
      }

      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
