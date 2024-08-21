import 'package:authentication_demo/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1B2236),
      appBar: AppBar(
        backgroundColor: const Color(0xff1B2236),
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              context.read<LoginCubit>().signOut().then(
                (_) {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              );
            },
          )
        ],
      ),
      body: Center(
        child: Text(
          'Welcome!',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.sp,
          ),
        ),
      ),
    );
  }
}
