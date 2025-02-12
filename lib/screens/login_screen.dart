import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ija_chat/constants/assets.dart';
import 'package:ija_chat/constants/constant.dart';
import 'package:ija_chat/cubit/auth_cubit.dart';
import 'package:ija_chat/screens/home_screen.dart';
import 'package:ija_chat/services/navigation_service.dart';
import 'package:ija_chat/widgets/custom_button.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/auth/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginSuccess) {
          GetIt.I
              .get<NavigationService>()
              .pushNamedAndRemoveAll(HomeScreen.routeName);
        } else if (state is AuthLoginError) {
          _passwordController.clear();
          toastification.show(
            title: Text(state.message),
            autoCloseDuration: const Duration(seconds: 5),
            alignment: Alignment.bottomCenter,
            icon: const Icon(
              Icons.error,
              color: Colors.white,
            ),
            showProgressBar: false,
            primaryColor: const Color.fromARGB(255, 219, 63, 52),
            style: ToastificationStyle.fillColored,
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Constant.kPadding),
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              Assets.assetsImagesLogo,
                            ),
                          ),
                        ),
                        width: 130,
                        height: 130,
                      ),
                      const SizedBox(
                        height: 20 / 2,
                      ),
                      const Text(
                        'Ija Chat',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20 * 2,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20 * 2,
                      ),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return CustomButton(
                            isLoading: state is AuthLoginLoading,
                            text: 'Login',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                toastification.dismissAll();
                                context.read<AuthCubit>().login(
                                    _emailController.text,
                                    _passwordController.text);
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: Color(0xFF0054DC),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
