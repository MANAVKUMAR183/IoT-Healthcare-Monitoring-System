import 'package:flutter/material.dart';
import '../services/api_service.dart';

class HealthDataProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  List<dynamic> _patients = [];
  List<dynamic> _devices = [];
  List<dynamic> _alerts = [];
  List<dynamic> _recentVitals = [];
  Map<String, dynamic> _dashboardStats = {};
  String? _error;

  bool get isLoading => _isLoading;
  List<dynamic> get patients => _patients;
  List<dynamic> get devices => _devices;
  List<dynamic> get alerts => _alerts;
  List<dynamic> get recentVitals => _recentVitals;
  Map<String, dynamic> get dashboardStats => _dashboardStats;
  String? get error => _error;

  Future<void> loadDashboardData() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Load all data in parallel
      final results = await Future.wait([
        _loadPatients(),
        _loadDevices(),
        _loadAlerts(),
        _loadDashboardStats(),
      ]);

      _patients = results[0] as List<dynamic>;
      _devices = results[1] as List<dynamic>;
      _alerts = results[2] as List<dynamic>;
      _dashboardStats = results[3] as Map<String, dynamic>;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMonitoringData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _recentVitals = await _apiService.getRecentVitalSigns();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _recentVitals = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadAlerts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _alerts = await _apiService.getAlerts();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _alerts = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadDevices() async {
    _isLoading = true;
    notifyListeners();

    try {
      _devices = await _apiService.getDevices();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _devices = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<dynamic>> _loadPatients() async {
    try {
      return await _apiService.getPatients();
    } catch (e) {
      return []; // Return empty list on error
    }
  }

  Future<List<dynamic>> _loadDevices() async {
    try {
      return await _apiService.getDevices();
    } catch (e) {
      return []; // Return empty list on error
    }
  }

  Future<List<dynamic>> _loadAlerts() async {
    try {
      return await _apiService.getAlerts();
    } catch (e) {
      return []; // Return empty list on error
    }
  }

  Future<Map<String, dynamic>> _loadDashboardStats() async {
    try {
      return await _apiService.getDashboardStats();
    } catch (e) {
      // Return mock stats if API fails
      return {
        'totalPatients': _patients.length,
        'activeDevices': _devices.length,
        'activeAlerts': _alerts.length,
        'avgHealthScore': 85.0,
      };
    }
  }

  Future<bool> createPatient(Map<String, dynamic> patient) async {
    try {
      await _apiService.createPatient(patient);
      await loadDashboardData(); // Refresh data
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> createDevice(Map<String, dynamic> device) async {
    try {
      await _apiService.createDevice(device);
      await loadDashboardData(); // Refresh data
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<List<dynamic>> getPatientVitalSigns(String patientId) async {
    try {
      return await _apiService.getVitalSigns(patientId);
    } catch (e) {
      return [];
    }
  }

  Future<bool> addVitalSigns(Map<String, dynamic> vitals) async {
    try {
      await _apiService.addVitalSigns(vitals);
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> resolveAlert(String alertId) async {
    try {
      await _apiService.resolveAlert(alertId);
      await loadDashboardData(); // Refresh data
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}