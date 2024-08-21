import 'package:authentication_demo/cubit/login_cubit.dart';
import 'package:authentication_demo/firebase_options.dart';
import 'package:authentication_demo/screens/home_screen.dart';
import 'package:authentication_demo/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Login',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: BlocProvider(
              create: (context) => LoginCubit(FirebaseAuth.instance),
              child: const LoginScreen(),
            ),
            routes: {
              '/login': (context) => BlocProvider(
                    create: (context) => LoginCubit(FirebaseAuth.instance),
                    child: const LoginScreen(),
                  ),
              '/home': (context) => BlocProvider(
                    create: (context) => LoginCubit(FirebaseAuth.instance),
                    child: const HomeScreen(),
                  ),
            },
          );
        });
  }
}
