import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5000'; // For Android emulator
  // static const String baseUrl = 'http://localhost:5000'; // For iOS simulator
  // static const String baseUrl = 'http://YOUR_LOCAL_IP:5000'; // For physical device

  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  // System Status
  Future<Map<String, dynamic>> getSystemStatus() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/api/status'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Failed to get system status');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Authentication
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Login failed');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Patients
  Future<List<dynamic>> getPatients() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/api/patients'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'] ?? [];
      }
      throw Exception('Failed to load patients');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> createPatient(Map<String, dynamic> patient) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/api/patients'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(patient),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body);
      }
      throw Exception('Failed to create patient');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> getPatient(String id) async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/api/patients/$id'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Failed to load patient');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Devices
  Future<List<dynamic>> getDevices() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/api/devices'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'] ?? [];
      }
      throw Exception('Failed to load devices');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> createDevice(Map<String, dynamic> device) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/api/devices'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(device),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body);
      }
      throw Exception('Failed to create device');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Vital Signs
  Future<List<dynamic>> getVitalSigns(String patientId) async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/api/vitals/$patientId'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'] ?? [];
      }
      throw Exception('Failed to load vital signs');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> addVitalSigns(Map<String, dynamic> vitals) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/api/vitals'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(vitals),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body);
      }
      throw Exception('Failed to add vital signs');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> getVitalTrends(String patientId) async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/api/vitals/trends/$patientId'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Failed to load trends');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Alerts
  Future<List<dynamic>> getAlerts() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/api/alerts'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'] ?? [];
      }
      throw Exception('Failed to load alerts');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> resolveAlert(String alertId) async {
    try {
      final response = await _client.put(
        Uri.parse('$baseUrl/api/alerts/$alertId/resolve'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Failed to resolve alert');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Analytics
  Future<Map<String, dynamic>> getDashboardStats() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/api/analytics/dashboard'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Failed to load dashboard stats');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // AI Chatbot
  Future<Map<String, dynamic>> sendChatMessage(String message, String sessionId) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/api/chatbot/chat'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'message': message,
          'sessionId': sessionId,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Failed to send message');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}

// Legacy compatibility - keeping the old interface for now
class MockDataService {
  static Future<bool> loginUser(String email, String password) async {
    try {
      final apiService = ApiService();
      await apiService.login(email, password);
      return true;
    } catch (e) {
      // Fallback to mock authentication for development
      if (email.contains('@') && password.length >= 6) {
        return true;
      }
      return false;
    }
  }

  static Future<Map<String, dynamic>> getUserProfile() async {
    await Future.delayed(const Duration(seconds: 1));

    return {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'age': 35,
      'bloodType': 'O+',
      'lastCheckup': '2024-03-15',
    };
  }
}
