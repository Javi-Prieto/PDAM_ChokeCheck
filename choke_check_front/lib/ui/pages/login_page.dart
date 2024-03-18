import 'package:choke_check_front/blocs/login/login_bloc.dart';
import 'package:choke_check_front/data/auth/repository/auth_repository.dart';
import 'package:choke_check_front/data/auth/repository/auth_repository_impl.dart';
import 'package:choke_check_front/data/auth/services/auth_service.dart';
import 'package:choke_check_front/ui/pages/home_page.dart';
import 'package:choke_check_front/ui/pages/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formLogin = GlobalKey<FormState>();
  final userTextController = TextEditingController();
  final passTextController = TextEditingController();

  AuthRepository authRepository =
      AuthRepositoryImpl(authService: AuthService.create());
  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(authRepository);
  }

  @override
  void dispose() {
    userTextController.dispose();
    passTextController.dispose();
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: _loginBloc,
        child: Scaffold(
          body:
              BlocConsumer<LoginBloc, LoginState>(buildWhen: (constext, state) {
            return state is LoginInitial ||
                state is DoLoginLoading ||
                state is DoLoginError;
          }, builder: (context, state) {
            if (state is LoginInitial) {
              return _buildLoginForm();
            } else if (state is DoLoginLoading) {
              return const CircularProgressIndicator();
            } else if (state is DoLoginError) {
              return Center(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  _errorMesage(state.errorMessage),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: const Text("Back to the Form"),
                  )
                ],
              ));
            } else {
              return const CircularProgressIndicator();
            }
          }, listenWhen: (context, state) {
            return state is DoLoginSuccess;
          }, listener: (context, state) {
            if (state is DoLoginSuccess) {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => const HomePage()));
            }
          }),
        ));
  }

  _buildLoginForm() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Colors.blue.shade900),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formLogin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back! We`ve missed your presence here',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  TextFormField(
                    controller: userTextController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Username',
                        fillColor: Colors.white,
                        filled: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passTextController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Password',
                        fillColor: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: SizedBox(
                      width: 350,
                      height: 56,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 7, 43, 97)),
                            elevation: MaterialStateProperty.all<double>(0),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                        onPressed: () {
                          if (_formLogin.currentState!.validate()) {
                            _loginBloc.add(DoLoginEvent(userTextController.text,
                                passTextController.text));
                          }
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text('Don`t have an account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const RegisterPage()));
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _errorMesage(String message) {
    if (message.contains('username')) {
      return const Text('Not existing username');
    } else if (message.contains('password')) {
      return const Text('Not valid Password');
    } else {
      return const Text('Not valid data');
    }
  }
}
