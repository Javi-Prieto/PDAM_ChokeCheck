import 'package:choke_check_front/blocs/register/register_bloc.dart';
import 'package:choke_check_front/data/auth/repository/auth_repository.dart';
import 'package:choke_check_front/data/auth/repository/auth_repository_impl.dart';
import 'package:choke_check_front/data/auth/services/auth_service.dart';
import 'package:choke_check_front/models/request/register_request.dart';
import 'package:choke_check_front/ui/pages/home_page.dart';
import 'package:choke_check_front/ui/pages/login_page.dart';
import 'package:choke_check_front/ui/pages/upload_belt_photo_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formRegister = GlobalKey<FormState>();
  final userTextController = TextEditingController();
  final passTextController = TextEditingController();
  final repPassTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final surnameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final heightNumberController = TextEditingController();
  final weightNumberController = TextEditingController();
  final ageNumberController = TextEditingController();
  var beltColorController = 'Please select your belt color';
  var sexController = '0';

  AuthRepository authRepository =
      AuthRepositoryImpl(authService: AuthService.create());
  late RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = RegisterBloc(authRepository);
  }

  @override
  void dispose() {
    userTextController.dispose();
    passTextController.dispose();
    repPassTextController.dispose();
    nameTextController.dispose();
    surnameTextController.dispose();
    emailTextController.dispose();
    heightNumberController.dispose();
    weightNumberController.dispose();
    ageNumberController.dispose();
    _registerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _registerBloc,
      child: Scaffold(
        body: BlocConsumer<RegisterBloc, RegisterState>(
          buildWhen: (constext, state) {
            return state is RegisterInitial ||
                state is DoRegisterLoading ||
                state is DoRegisterError;
          },
          builder: (context, state) {
            if (state is RegisterInitial) {
              return _buildRegisterForm();
            } else if (state is DoRegisterLoading) {
              return const CircularProgressIndicator();
            } else if (state is DoRegisterError) {
              return Center(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  _errorMessage(state.errorMessage),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const RegisterPage()));
                    },
                    child: const Text("Back to the Form"),
                  )
                ],
              ));
            } else {
              return Text(state.toString());
            }
          },
          listenWhen: (context, state) {
            return state is DoRegisterSuccess;
          },
          listener: (context, state) {
            if (state is DoRegisterSuccess) {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => UploadBeltPhotoScreen(beltSelected: beltColorController)));
            }
          },
        ),
      ),
    );
  }

  _buildRegisterForm() {
    final options = [
      'Please select your belt color',
      'WHITE',
      'BLUE',
      'PURPLE',
      'BROWN',
      'BLACK',
      'RED_BLACK',
      'RED_WHITE',
      'RED'
    ];
    final optionsNumber = ['0', '1'];
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Colors.blue.shade900),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formRegister,
          child: ListView(
            children: [
              const Text(
                'CHOKECHECK',
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
                    height: 20,
                  ),
                  TextFormField(
                    controller: repPassTextController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Repeat Password',
                        fillColor: Colors.white),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: TextFormField(
                          controller: nameTextController,
                          decoration: const InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              labelText: 'Name',
                              fillColor: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: TextFormField(
                          controller: surnameTextController,
                          decoration: const InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              labelText: 'Surname',
                              fillColor: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailTextController,
                    decoration: const InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Email',
                        fillColor: Colors.white),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: TextFormField(
                          controller: ageNumberController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              labelText: 'Age',
                              fillColor: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: TextFormField(
                          controller: weightNumberController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              labelText: 'Weight',
                              fillColor: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: TextFormField(
                          controller: heightNumberController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              labelText: 'Height',
                              fillColor: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: const TextStyle(),
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            hintText: 'Please select your belt color',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                          value: beltColorController,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              beltColorController = value!;
                              state.didChange(value);
                            });
                          },
                          items: options.map((String e) {
                            return DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),
                        )),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: const TextStyle(),
                            errorStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 16.0),
                            hintText: 'Please select your sex',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                          value: sexController,
                          isDense: true,
                          onChanged: (value) {
                            setState(() {
                              sexController = value!;
                              state.didChange(value);
                            });
                          },
                          items: optionsNumber.map((String e) {
                            return DropdownMenuItem<String>(
                              value: e,
                              child: Text(e == '0' ? 'Male' : 'Female'),
                            );
                          }).toList(),
                        )),
                      );
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
                          if (_formRegister.currentState!.validate()) {
                            RegisterRequest newUser = RegisterRequest(
                                username: userTextController.text,
                                password: passTextController.text,
                                repeatPassword: repPassTextController.text,
                                name: nameTextController.text,
                                surname: surnameTextController.text,
                                height: int.parse(heightNumberController.text),
                                weight: int.parse(weightNumberController.text),
                                email: emailTextController.text,
                                age: int.parse(ageNumberController.text),
                                beltColor: beltColorController,
                                byte: int.parse(sexController));
                            _registerBloc.add(DoRegisterEvent(user: newUser));
                          }
                        },
                        child: const Text(
                          "Register",
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
                      const Text('Already Registered?'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: const Text(
                            'Login',
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

  _errorMessage(String message) {
    if (message.contains('username')) {
      return const Text('Not existing username');
    } else if (message.contains('password')) {
      return const Text('Not valid Password');
    } else if (message.contains('age')) {
      return const Text('Not valid age');
    } else if (message.contains('weight')) {
      return const Text('Not valid weight');
    } else if (message.contains('height')) {
      return const Text('Not valid height');
    } else {
      return const Text('Not valid data');
    }
  }
}
