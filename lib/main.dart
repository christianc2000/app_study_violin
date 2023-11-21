import 'package:app_study_violin/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'config/theme/app_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '!Study Violin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
      ),
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'lib/images/Logo.png'), // Reemplaza con la ruta correcta
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(35.0),
                child: Center(
                  child: Text(
                    '¡Study Volin!',
                    style: TextStyle(
                        fontSize: 40.0,
                        color: AppColors.textColor2,
                        fontFamily: 'Roboto'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => RegisterScreen()),
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.btncolor1,
                        minimumSize: const Size(300.0, 60.0),
                      ),
                      child: const Text(
                        'CREAR CUENTA',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.btncolor2,
                        minimumSize: const Size(300.0, 50.0),
                      ),
                      child: const Text(
                        'INICIAR SESION',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
