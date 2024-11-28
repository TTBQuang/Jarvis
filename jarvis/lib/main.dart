import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jarvis/constant.dart';
import 'package:jarvis/repository/auth_repository.dart';
import 'package:jarvis/repository/knowledge_repository.dart';
import 'package:jarvis/repository/pricing_repository.dart';
import 'package:jarvis/repository/prompt_repository.dart';
import 'package:jarvis/view_model/auth_view_model.dart';
import 'package:jarvis/view_model/chat_view_model.dart';
import 'package:jarvis/view_model/drawer_view_model.dart';
import 'package:jarvis/view_model/knowledge_view_model.dart';
import 'package:jarvis/view_model/pricing_view_model.dart';
import 'package:jarvis/view_model/prompt_view_model.dart';
import 'package:provider/provider.dart';
import 'package:jarvis/view/home/home_screen.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  final AuthRepository authRepository = AuthRepository();
  final authViewModel = AuthViewModel(authRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DrawerViewModel(0)),
        ChangeNotifierProvider(create: (context) => authViewModel),
        ChangeNotifierProvider(
          create: (context) => PromptViewModel(
            authRepository: authRepository,
            promptRepository: PromptRepository(authViewModel: authViewModel),
            authViewModel: authViewModel,
          ),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return ChatViewModel(authViewModel: context.read<AuthViewModel>());
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return PricingViewModel(
              authViewModel: authViewModel,
              pricingRepository: PricingRepository(),
            )..fetchSubscription();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return KnowledgeViewModel(
              authViewModel: authViewModel,
              knowledgeRepository: KnowledgeRepository(),
            )..fetchKnowledgeList();
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // Perform the operation after the widget is initialized.
    Future.microtask(() {
      final chatViewModel = context.read<ChatViewModel>();
      final promptsViewModel = context.read<PromptViewModel>();
      chatViewModel.getConversations();
      promptsViewModel.fetchPrivatePrompts(limit: defaultLimitPrompt);
      promptsViewModel.fetchPublicPrompt(limit: defaultLimitPrompt);
    });
  }

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
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
