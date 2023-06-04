import 'package:aliexpo/ui/layout/shop_layout.dart';
import 'package:aliexpo/ui/modules/login/cubit/cubit.dart';
import 'package:aliexpo/ui/modules/login/cubit/states.dart';
import 'package:aliexpo/ui/shared/components/components.dart';
import 'package:aliexpo/ui/shared/components/constants.dart';
import 'package:aliexpo/data/network/local/shared_preferences.dart';
import 'package:aliexpo/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccesslState) {
            if (state.loginData?.status == true) {
              token = state.loginData?.data?.token;
              CacheHelper.saveData(
                      key: 'token', value: state.loginData?.data?.token)
                  .then((value) {
                if (value == true) {
                  NavigateAndFinish(context, ShopLyaout());
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("${state.loginData?.message}"),
                  ));
                }
              });
            } else {
              print('message --->${state.loginData?.message}');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text("${state.loginData?.message}"),
              ));
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Log in ',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          Text(
                            '${cubit.userData?.message} ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Email Address//

                          defaultFormaFielde(
                            keyboardType: TextInputType.emailAddress,
                            controllerField: emailController,
                            border: 'outlined',
                            text: 'Email Address',
                            prefixIcon: Icons.email,
                            validatorField: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Email Address must not empty';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          // Password
                          defaultFormaFielde(
                            isPassword: cubit.isPassword,
                            keyboardType: TextInputType.visiblePassword,
                            controllerField: passwordController,
                            border: 'outlined',
                            text: 'Password',
                            prefixIcon: Icons.lock,
                            suffixIcon: cubit.isPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            showPassword: () {
                              cubit.ChangePasswordShow();
                            },
                            validatorField: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Password must not empty';
                              }
                              return null;
                            },
                            onSubmitted: (Value) {
                              if (formKey.currentState!.validate()) {
                                cubit.Login(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          //
                          state is! LoginLodingState
                              ? defaultButton(
                                  colorButton: defaultColor,
                                  textButton: 'LOG IN',
                                  functionButton: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.Login(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  })
                              : const CircularProgressIndicator() // Button LOG IN

                          ,
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account?'),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text('Register New'))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
