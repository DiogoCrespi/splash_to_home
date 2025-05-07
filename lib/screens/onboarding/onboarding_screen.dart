import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_to_home/screens/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

// Tela de Onboarding com navegação e entrada de nome
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Controlador para gerenciar a navegação entre páginas
  final PageController _pageController = PageController();
  // Página atual do onboarding
  int _currentPage = 0;
  // Controlador para o campo de texto do nome
  final TextEditingController _nameController = TextEditingController();
  // Controla a visibilidade dos botões de navegação
  bool _showNavigationButtons = false;

  // Lista de páginas do onboarding com título, descrição e imagem
  final List<Map<String, String>> _onboardingPages = [
    {
      'title': 'Bem-vindo ao App',
      'description': 'Descubra uma nova forma de interagir com nosso aplicativo.',
      'image': 'assets/images/onboarding1.png',
    },
    {
      'title': 'Recursos Incríveis',
      'description': 'Acesse recursos exclusivos e melhore sua experiência.',
      'image': 'assets/images/onboarding2.png',
    },
    {
      'title': 'Personalização',
      'description': 'Configure o app do seu jeito e aproveite ao máximo.',
      'image': 'assets/images/onboarding3.png',
    },
  ];

  @override
  void dispose() {
    // Libera os recursos dos controladores
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  // Salva o nome do usuário e navega para a tela de boas-vindas
  Future<void> _saveNameAndNavigate() async {
    if (_nameController.text.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', _nameController.text);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(name: _nameController.text),
          ),
        );
      }
    }
  }

  // Navega para a próxima página
  void _nextPage() {
    if (_currentPage < _onboardingPages.length) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Navega para a página anterior
  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Navega para uma página específica
  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MouseRegion(
          // Mostra/esconde os botões de navegação ao passar o mouse
          onEnter: (_) => setState(() => _showNavigationButtons = true),
          onExit: (_) => setState(() => _showNavigationButtons = false),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      itemCount: _onboardingPages.length + 1,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index < _onboardingPages.length) {
                          return _buildOnboardingPage(_onboardingPages[index]);
                        } else {
                          return _buildNameInputPage();
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: _buildPageIndicator(),
                  ),
                ],
              ),
              // Botão de voltar
              if (_currentPage > 0 && _currentPage < _onboardingPages.length)
                Positioned(
                  left: 20,
                  top: MediaQuery.of(context).size.height / 2 - 30,
                  child: AnimatedOpacity(
                    opacity: _showNavigationButtons ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: _buildNavigationButton(
                      icon: Icons.arrow_back_ios_rounded,
                      onPressed: _previousPage,
                    ),
                  ),
                ),
              // Botão de próximo
              if (_currentPage < _onboardingPages.length)
                Positioned(
                  right: 20,
                  top: MediaQuery.of(context).size.height / 2 - 30,
                  child: AnimatedOpacity(
                    opacity: _showNavigationButtons ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: _buildNavigationButton(
                      icon: Icons.arrow_forward_ios_rounded,
                      onPressed: _nextPage,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 216, 210, 213),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blue.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              color: Colors.blue,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(Map<String, String> page) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          _previousPage();
        } else if (details.primaryVelocity! < 0) {
          _nextPage();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: page['image']!,
              height: 200,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fadeInDuration: const Duration(milliseconds: 300),
              memCacheWidth: 400,
              memCacheHeight: 400,
            ),
            const SizedBox(height: 40),
            Text(
              page['title']!,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              page['description']!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameInputPage() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Qual é o seu nome?',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 600,
            child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Digite seu nome',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _saveNameAndNavigate,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _onboardingPages.length + 1,
        (index) => GestureDetector(
          onTap: () => _goToPage(index),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage == index ? Colors.blue : Colors.grey[300],
            ),
          ),
        ),
      ),
    );
  }
} 