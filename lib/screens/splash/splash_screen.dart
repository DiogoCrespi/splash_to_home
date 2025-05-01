import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:splash_to_home/screens/onboarding/onboarding_screen.dart';

// Tela de Splash com animação e redirecionamento
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Redireciona para Onboarding após 3 segundos
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Posiciona a animação da logo no centro da tela
          Positioned(
            left: MediaQuery.of(context).size.width * 0.08,
            top: MediaQuery.of(context).size.height * 0.05,
            child: Transform.scale(
              scale: 3.0,
              alignment: Alignment.center,
              // Exibe a animação Lottie da logo
              child: Lottie.asset(
                'assets/animations/logo_animation.json',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.contain,
                repeat: false,
                onLoaded: (composition) {
                  composition.duration;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
} 