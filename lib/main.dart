import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ija_chat/firebase_options.dart';
import 'package:ija_chat/screens/splash_screen.dart';

Future<void> _initialization() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> _onInitializationComplete() async {
  print("done");
}

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ija Chat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: const Color(0XFF222331),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(
        initialization: _initialization,
        onInitializationComplete: _onInitializationComplete,
      ),
    );
  }
}
