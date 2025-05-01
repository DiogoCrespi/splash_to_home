import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Tela de boas-vindas que exibe uma mensagem personalizada com o nome do usuário
class WelcomeScreen extends StatelessWidget {
  // Nome do usuário que será exibido na mensagem de boas-vindas
  final String name;

  const WelcomeScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ícone de confirmação verde
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
              const SizedBox(height: 20),
              // Mensagem de boas-vindas personalizada
              Text(
                'Bem-vindo, $name!',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Mensagem secundária
              Text(
                'Seu aplicativo está pronto para uso.',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 