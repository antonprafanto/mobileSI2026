import 'package:flutter/material.dart';
import '../models/registrant_model.dart';

/// Provider untuk mengelola state form registrasi
class RegistrationProvider extends ChangeNotifier {
  RegistrantModel _data = RegistrantModel();
  int _currentStep = 0;
  bool _isSubmitting = false;
  bool _isSubmitted = false;

  // Getters
  RegistrantModel get data => _data;
  int get currentStep => _currentStep;
  bool get isSubmitting => _isSubmitting;
  bool get isSubmitted => _isSubmitted;
  bool get isFirstStep => _currentStep == 0;
  bool get isLastStep => _currentStep == 2;

  // ============================================================
  // UPDATE DATA METHODS
  // ============================================================

  void updateName(String value) {
    _data = _data.copyWith(name: value);
    // Tidak notifyListeners() - tidak perlu rebuild saat ketik
  }

  void updateEmail(String value) {
    _data = _data.copyWith(email: value);
  }

  void updatePhone(String value) {
    _data = _data.copyWith(phone: value);
  }

  void updateBirthDate(DateTime? date) {
    _data = _data.copyWith(birthDate: date);
    notifyListeners(); // Perlu rebuild untuk tampilkan tanggal
  }

  void updateGender(String value) {
    _data = _data.copyWith(gender: value);
    notifyListeners();
  }

  void updateTicketType(String value) {
    _data = _data.copyWith(ticketType: value);
    notifyListeners();
  }

  void updateSession(String value) {
    _data = _data.copyWith(session: value);
    notifyListeners();
  }

  void toggleInterest(String interest) {
    final current = List<String>.from(_data.interests);
    if (current.contains(interest)) {
      current.remove(interest);
    } else {
      current.add(interest);
    }
    _data = _data.copyWith(interests: current);
    notifyListeners();
  }

  void updateVegetarian(bool value) {
    _data = _data.copyWith(vegetarian: value);
    notifyListeners();
  }

  void updateGuestCount(int value) {
    _data = _data.copyWith(guestCount: value);
    notifyListeners();
  }

  void updateCity(String? value) {
    _data = _data.copyWith(city: value);
    notifyListeners();
  }

  // ============================================================
  // STEP NAVIGATION
  // ============================================================

  void nextStep() {
    if (_currentStep < 2) {
      _currentStep++;
      notifyListeners();
    }
  }

  void prevStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  // ============================================================
  // SUBMIT
  // ============================================================

  Future<void> submitForm() async {
    _isSubmitting = true;
    notifyListeners();

    try {
      // Simulasi proses submit (misal: HTTP POST)
      await Future.delayed(const Duration(seconds: 2));
      _isSubmitted = true;
    } catch (e) {
      debugPrint('Submit error: $e');
      rethrow; // Lempar ulang agar UI bisa handle
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  // Reset form ke kondisi awal
  void resetForm() {
    _data = RegistrantModel();
    _currentStep = 0;
    _isSubmitted = false;
    notifyListeners();
  }
}
