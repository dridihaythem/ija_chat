import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ija_chat/firebase_options.dart';
import 'package:ija_chat/screens/home_screen.dart';
import 'package:ija_chat/screens/login_screen.dart';
import 'package:ija_chat/screens/register_screen.dart';
import 'package:ija_chat/screens/splash_screen.dart';
import 'package:ija_chat/services/auth_service.dart';
import 'package:ija_chat/services/database_service.dart';
import 'package:ija_chat/services/navigation_service.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const SplashScreen(
        initialization: _initialization,
        onInitializationComplete: _onInitializationComplete,
      ),
  LoginScreen.routeName: (context) => const LoginScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
};

Future<void> _initialization() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GetIt.I.registerSingleton<NavigationService>(NavigationService());
  GetIt.I.registerSingleton<AuthService>(AuthService());
  GetIt.I.registerSingleton<DatabaseService>(DatabaseService());
}

Future<void> _onInitializationComplete() async {
  GetIt.I.get<NavigationService>().pushNamed(LoginScreen.routeName);
}
