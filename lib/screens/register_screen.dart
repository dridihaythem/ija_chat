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

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/auth/register';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthRegisterSuccess || current is AuthRegisterError,
      listener: (context, state) {
        if (state is AuthRegisterSuccess) {
          GetIt.I
              .get<NavigationService>()
              .pushNamedAndRemoveAll(HomeScreen.routeName);
        } else if (state is AuthRegisterError) {
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
        appBar: AppBar(
          backgroundColor: const Color(0XFF222331),
          elevation: 0,
          centerTitle: true,
          title: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                  Assets.assetsImagesLogo,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text('Register'),
            ],
          ),
        ),
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
                        width: 150,
                        height: 130,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://firebasestorage.googleapis.com/v0/b/ija-chat-3ed15.firebasestorage.app/o/users%2F3mHS6p3ZbAYBiqBnwOUoCLxF6Lq1%2Fprofile.jpg?alt=media&token=40bc3907-39d0-4101-8876-48afba31a24d',
                            ),
                          ),
                        ),
                        child: const Stack(
                          children: [
                            Positioned(
                              top: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20 * 2,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Name',
                        ),
                        controller: _nameController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          } else if (value.length < 3) {
                            return 'Name must be at least 3 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
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
                            isLoading: state is AuthRegisterLoading,
                            text: 'Register',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                toastification.dismissAll();
                                context.read<AuthCubit>().register(
                                    _nameController.text,
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
