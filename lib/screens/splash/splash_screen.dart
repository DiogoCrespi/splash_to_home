import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:splash_to_home/screens/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Lottie.asset(
          'assets/animations/logo_animation.json',
          width: MediaQuery.of(context).size.width * 0.5, 
          height: MediaQuery.of(context).size.width * 0.5, // Mantém proporção quadrada
          fit: BoxFit.contain,
          repeat: false,
          alignment: Alignment.center, // Garante alinhamento central
          frameBuilder: (context, child, composition) {
            return Transform.scale(
              scale: 1.5, // Ajuste fino da escala
              child: child,
            );
          },
        ),
      ),
    );
  }
}