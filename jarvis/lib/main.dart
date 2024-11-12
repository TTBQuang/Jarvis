import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:jarvis/repository/auth_repository.dart';
import 'package:jarvis/repository/prompt_repository.dart';
import 'package:jarvis/view_model/auth_view_model.dart';
import 'package:jarvis/view_model/drawer_view_model.dart';
import 'package:jarvis/view_model/prompt_view_model.dart';
import 'package:provider/provider.dart';
import 'package:jarvis/view/home/home_screen.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  final AuthRepository authRepository = AuthRepository();
  final authViewModel = AuthViewModel(authRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DrawerViewModel(0)),
        ChangeNotifierProvider(
            create: (context) => authViewModel),
        ChangeNotifierProvider(
          create: (context) => PromptViewModel(
            authRepository: authRepository,
            promptRepository: PromptRepository(),
            authViewModel: authViewModel,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp.material(
      title: 'Jarvis',
      materialThemeBuilder: (context, theme) {
        return theme.copyWith(
          colorScheme:
              MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? ColorScheme.fromSeed(
                      seedColor: Colors.deepPurple, brightness: Brightness.dark)
                  : ColorScheme.fromSeed(
                      seedColor: Colors.lightBlueAccent,
                      brightness: Brightness.light),
          useMaterial3: true,
        );
      },
      themeMode: ThemeMode.system,
      builder: (context, child) {
        return FTheme(
            data: MediaQuery.of(context).platformBrightness == Brightness.dark
                ? FThemes.blue.dark
                : FThemes.blue.light,
            child: child!);
      },
      home: const HomeScreen(),
    );
  }
}
