import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api'; // Update this to your backend URL

  Future<List<dynamic>> getPatients() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/patients'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load patients');
      }
    } catch (e) {
      // Return mock data if API is not available
      return [
        {
          'id': '1',
          'name': 'John Doe',
          'age': 45,
          'condition': 'Hypertension',
          'last_checkup': '2024-01-15',
          'status': 'stable'
        },
        {
          'id': '2',
          'name': 'Jane Smith',
          'age': 32,
          'condition': 'Diabetes',
          'last_checkup': '2024-01-10',
          'status': 'monitoring'
        },
      ];
    }
  }

  Future<List<dynamic>> getDevices() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/devices'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load devices');
      }
    } catch (e) {
      // Return mock data if API is not available
      return [
        {
          'id': '1',
          'name': 'Heart Rate Monitor',
          'type': 'heart_rate_monitor',
          'status': 'active',
          'battery': 85,
          'patient_id': '1'
        },
        {
          'id': '2',
          'name': 'Blood Pressure Monitor',
          'type': 'blood_pressure_monitor',
          'status': 'active',
          'battery': 92,
          'patient_id': '1'
        },
        {
          'id': '3',
          'name': 'Smart Scale',
          'type': 'smart_scale',
          'status': 'offline',
          'battery': 15,
          'patient_id': '2'
        },
      ];
    }
  }

  Future<List<dynamic>> getAlerts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/alerts'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load alerts');
      }
    } catch (e) {
      // Return mock data if API is not available
      return [
        {
          'id': '1',
          'title': 'High Blood Pressure Alert',
          'message': 'Patient John Doe has elevated blood pressure reading of 160/95 mmHg',
          'severity': 'warning',
          'timestamp': '2024-01-20T10:30:00Z',
          'read': false,
          'device': 'Blood Pressure Monitor',
          'patient_id': '1'
        },
        {
          'id': '2',
          'title': 'Low Battery Warning',
          'message': 'Smart Scale battery is at 15%. Please replace batteries.',
          'severity': 'info',
          'timestamp': '2024-01-20T09:15:00Z',
          'read': false,
          'device': 'Smart Scale',
          'patient_id': '2'
        },
        {
          'id': '3',
          'title': 'Irregular Heart Rate',
          'message': 'Detected irregular heart rhythm. Please consult healthcare provider.',
          'severity': 'critical',
          'timestamp': '2024-01-20T08:45:00Z',
          'read': true,
          'device': 'Heart Rate Monitor',
          'patient_id': '1'
        },
      ];
    }
  }

  Future<Map<String, dynamic>> getDashboardStats() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/dashboard/stats'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load dashboard stats');
      }
    } catch (e) {
      // Return mock data if API is not available
      return {
        'totalPatients': 2,
        'activeDevices': 2,
        'activeAlerts': 3,
        'avgHealthScore': 78.5,
      };
    }
  }

  Future<List<dynamic>> getRecentVitalSigns() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/vitals/recent'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load vital signs');
      }
    } catch (e) {
      // Return mock data if API is not available
      return [
        {
          'id': '1',
          'patient_id': '1',
          'heart_rate': 72,
          'blood_pressure': '120/80',
          'oxygen_level': 98,
          'temperature': 98.6,
          'timestamp': '2024-01-20T10:00:00Z'
        },
        {
          'id': '2',
          'patient_id': '1',
          'heart_rate': 75,
          'blood_pressure': '125/82',
          'oxygen_level': 97,
          'temperature': 98.4,
          'timestamp': '2024-01-20T09:30:00Z'
        },
        {
          'id': '3',
          'patient_id': '2',
          'heart_rate': 68,
          'blood_pressure': '118/78',
          'oxygen_level': 99,
          'temperature': 98.2,
          'timestamp': '2024-01-20T09:00:00Z'
        },
      ];
    }
  }

  Future<List<dynamic>> getVitalSigns(String patientId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/patients/$patientId/vitals'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load vital signs');
      }
    } catch (e) {
      return [];
    }
  }

  Future<void> createPatient(Map<String, dynamic> patient) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/patients'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(patient),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to create patient');
      }
    } catch (e) {
      throw Exception('Failed to create patient: $e');
    }
  }

  Future<void> createDevice(Map<String, dynamic> device) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/devices'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(device),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to create device');
      }
    } catch (e) {
      throw Exception('Failed to create device: $e');
    }
  }

  Future<void> addVitalSigns(Map<String, dynamic> vitals) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/vitals'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(vitals),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to add vital signs');
      }
    } catch (e) {
      throw Exception('Failed to add vital signs: $e');
    }
  }

  Future<void> resolveAlert(String alertId) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/alerts/$alertId/resolve'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to resolve alert');
      }
    } catch (e) {
      throw Exception('Failed to resolve alert: $e');
    }
  }

  Future<Map<String, dynamic>> sendChatMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/chat'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'message': message}),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to send chat message');
      }
    } catch (e) {
      // Return mock response if API is not available
      return {
        'response': 'I\'m sorry, I\'m currently unable to connect to the healthcare AI service. Please try again later or consult with your healthcare provider for immediate assistance.'
      };
    }
  }
}