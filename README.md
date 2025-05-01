# Splash to Home

Um aplicativo Flutter que demonstra a implementação de:
- Splash Screen Nativa
- Splash Screen Animada
- Onboarding com 3 telas
- Tela de Boas-vindas personalizada

## Requisitos

- Flutter SDK (versão 3.7.2 ou superior)
- Dart SDK
- Chrome (para execução web)

## Instalação

1. Clone o repositório:
```bash
git clone [URL_DO_REPOSITÓRIO]
cd splash_to_home
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Gere a splash screen nativa:
```bash
flutter pub run flutter_native_splash:create
```

## Executando o Aplicativo

Para executar o aplicativo no Chrome:
```bash
flutter run -d chrome
```

## Estrutura do Projeto

```
lib/
  ├── screens/
  │   ├── splash/
  │   │   └── splash_screen.dart
  │   ├── onboarding/
  │   │   └── onboarding_screen.dart
  │   └── welcome/
  │       └── welcome_screen.dart
  ├── widgets/
  └── main.dart
```

## Funcionalidades

1. **Splash Screen Nativa**
   - Carregamento instantâneo com logo centralizado
   - Configurada via flutter_native_splash

2. **Splash Screen Animada**
   - Animação de fade-in
   - Rotação da logo
   - Transição suave para o onboarding

3. **Onboarding**
   - 3 telas com conteúdo informativo
   - Indicador de progresso
   - Tela final com campo para nome do usuário

4. **Tela de Boas-vindas**
   - Mensagem personalizada com o nome do usuário
   - Design moderno e limpo

## Dependências

- flutter_native_splash: ^2.3.10
- lottie: ^2.7.0
- shared_preferences: ^2.2.2
- google_fonts: ^6.1.0
