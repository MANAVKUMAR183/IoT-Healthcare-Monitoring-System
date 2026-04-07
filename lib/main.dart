import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/patient_dashboard.dart';
import 'screens/device_management_screen.dart';
import 'screens/health_monitoring_screen.dart';
import 'screens/alerts_screen.dart';
import 'screens/chatbot_screen.dart';
import 'services/api_service.dart';
import 'services/auth_service.dart';
import 'providers/health_data_provider.dart';
import 'providers/auth_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SmartHealthcareApp());
}

class SmartHealthcareApp extends StatelessWidget {
  const SmartHealthcareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HealthDataProvider()),
        Provider(create: (_) => ApiService()),
        Provider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: 'IoT Healthcare Monitor',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF667EEA),
            brightness: Brightness.light,
          ),
          fontFamily: 'Inter',
          cardTheme: CardTheme(
            elevation: 8,
            shadowColor: Colors.black.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 4,
              shadowColor: Colors.black.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF667EEA), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF667EEA),
            brightness: Brightness.dark,
          ),
          fontFamily: 'Inter',
        ),
        home: const SplashScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/dashboard': (context) => const PatientDashboard(),
          '/devices': (context) => const DeviceManagementScreen(),
          '/monitoring': (context) => const HealthMonitoringScreen(),
          '/alerts': (context) => const AlertsScreen(),
          '/chatbot': (context) => const ChatbotScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
} 