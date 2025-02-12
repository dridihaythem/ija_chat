import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ija_chat/bloc_observer.dart';
import 'package:ija_chat/constants/routes.dart';
import 'package:ija_chat/cubit/auth_cubit.dart';
import 'package:ija_chat/services/navigation_service.dart';
import 'package:toastification/toastification.dart';

void main() async {
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: ToastificationWrapper(
        child: MaterialApp(
          title: 'Ija Chat',
          theme: ThemeData(
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0XFF222331),
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: Color(0XFF1E1E25),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(7),
                ),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width * 0.60, 60),
                backgroundColor: const Color(0xFF0054DC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          navigatorKey: NavigationService.navigatorKey,
          routes: routes,
        ),
      ),
    );
  }
}
