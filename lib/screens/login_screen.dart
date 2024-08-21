import 'package:authentication_demo/cubit/login_cubit.dart';
import 'package:authentication_demo/cubit/login_state.dart';
import 'package:authentication_demo/widgets/custom_button.dart';
import 'package:authentication_demo/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1B2236),
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is LoginSuccess) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(left: 40.w, right: 45.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 150.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Login!',
                      style: TextStyle(
                        color: const Color(0xffCD5B97),
                        fontWeight: FontWeight.w700,
                        fontSize: 41.sp,
                      )),
                ),
                SizedBox(height: 100.h),
                CustomTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email,

                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  showObscureIcon: true,
                  prefixIcon: Icons.lock,

                ),
                SizedBox(height: 62.h),
                if (state is LoginLoading)
                  const CircularProgressIndicator(
                    color: Colors.white,
                  )
                else
                  CustomButton(
                    onTap: () {
                      // final email = _emailController.text;
                      // final password = _passwordController.text;

                      context.read<LoginCubit>().logInWithEmailAndPassword(
                            _emailController.text,
                            _passwordController.text,
                          );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
