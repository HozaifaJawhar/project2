import 'package:ammerha_volunteer/core/models/register_helper.dart';
import 'package:ammerha_volunteer/core/models/registration_data.dart';
import 'package:ammerha_volunteer/core/services/auth/auth_services.dart';
import 'package:flutter/material.dart';

class RegistrationProvider extends ChangeNotifier {
  final AuthService _service = AuthService();

  int _currentStep = 0;
  bool _isSubmitting = false;
  final RegistrationData _data = RegistrationData();
  bool _isLoadingOptions = false;
  List<Department> _departments = [];
  List<Skill> _skills = [];

  int get currentStep => _currentStep;
  bool get isSubmitting => _isSubmitting;
  RegistrationData get registrationData => _data;
  bool get isLoadingOptions => _isLoadingOptions;
  List<Department> get departments => _departments;
  List<Skill> get skills => _skills;

  void nextStep() {
    if (_currentStep < 3) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  void selectDepartment(int departmentId) {
    _data.selectedDepartmentId = departmentId;
    notifyListeners();
  }

  Future<void> fetchRegistrationOptions() async {
    if (_departments.isNotEmpty && _skills.isNotEmpty) return;
    _isLoadingOptions = true;
    notifyListeners();
    try {
      final options = await _service.fetchRegistrationOptions();
      _departments = options['departments'];
      _skills = options['skills'];
    } catch (e) {
      // Handle error appropriately
    }
    _isLoadingOptions = false;
    notifyListeners();
  }

  Future<bool> submitRegistration() async {
    _isSubmitting = true;
    notifyListeners();
    try {
      await _service.registerVolunteer(_data);
      _isSubmitting = false;
      notifyListeners();
      return true; // Success
    } catch (e) {
      _isSubmitting = false;
      notifyListeners();
      return false; // Failure
    }
  }
}
