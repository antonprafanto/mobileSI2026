import 'package:flutter/foundation.dart';
import '../models/registrant_model.dart';

class RegistrationProvider extends ChangeNotifier {
  final List<Registrant> _registrants = [];

  List<Registrant> get registrants => List.unmodifiable(_registrants);
  int get count => _registrants.length;

  void addRegistrant(Registrant registrant) {
    _registrants.add(registrant);
    notifyListeners();
  }

  void removeRegistrant(String id) {
    _registrants.removeWhere((r) => r.id == id);
    notifyListeners();
  }

  Registrant? getById(String id) {
    try {
      return _registrants.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }

  bool isEmailRegistered(String email) {
    return _registrants.any(
      (r) => r.email.toLowerCase() == email.toLowerCase(),
    );
  }
}
