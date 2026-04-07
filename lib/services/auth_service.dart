import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mock_data_service.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  Future<bool> login(String email, String password) async {
    try {
      final response = await ApiService().login(email, password);
      if (response['success'] == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_tokenKey, response['token'] ?? '');
        await prefs.setString(_userKey, json.encode(response['user'] ?? {}));
        return true;
      }
      return false;
    } catch (e) {
      // Fallback to mock authentication
      return await MockDataService.loginUser(email, password);
    }
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    return token != null && token.isNotEmpty;
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userKey);
    if (userData != null) {
      return json.decode(userData);
    }
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
}