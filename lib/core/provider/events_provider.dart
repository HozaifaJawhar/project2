import 'package:ammerha_volunteer/core/models/event.dart';
import 'package:ammerha_volunteer/core/services/events_service.dart';
import 'package:flutter/foundation.dart';

class EventsProvider extends ChangeNotifier {
  final EventsService _service;

  EventsProvider(this._service);

  List<Eventt> _events = [];
  List<Eventt> get events => _events;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchEvents({String? token, bool force = false}) async {
    if (_events.isNotEmpty && !force) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _events = await _service.getEvents(token: token);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh({String? token}) async {
    _error = null;
    try {
      _events = await _service.getEvents(token: token);
    } catch (e) {
      _error = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<String> registerToEvent(Eventt event, String token) async {
    try {
      final result = await _service.registerVolunteer(event.id, token);

      if (result == "success") {
        final updated = event.copyWith(
          acceptedCount: (event.acceptedCount ?? 0) + 1,
        );

        final index = _events.indexWhere((e) => e.id == event.id);
        if (index != -1) {
          _events[index] = updated;
        }

        notifyListeners();
      } else if (result == "already_registered") {
        // يمكن تحديث الزر مباشرة
        final index = _events.indexWhere((e) => e.id == event.id);
        if (index != -1) {
          _events[index] = event; // أو أي تعديل خفيف لو حاب تظهر
        }
        notifyListeners();
      }

      return result;
    } catch (e) {
      return "failed";
    }
  }
}
