import 'dart:async';
import 'dart:developer' as developer;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:myport4lio/core/constants/app_colors.dart';
import 'package:myport4lio/core/service_locator.dart';
import 'package:myport4lio/features/about/view/credits.dart';
import 'package:myport4lio/features/developer/bloc/developer_bloc.dart';
import 'package:myport4lio/features/project_details/bloc/project_details_bloc.dart';
import 'package:myport4lio/features/projects/bloc/projects_bloc.dart';
import 'package:myport4lio/routes/app_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Константы для подключения к сервисам
const String supabaseUrl = 'https://oafjxciedawpsmilkrqz.supabase.co';
const String supabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9hZmp4Y2llZGF3cHNtaWxrcnF6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ5MjE1MzcsImV4cCI6MjA2MDQ5NzUzN30.qdCIUy3w1eqG-lEB0kQxgJabFCIycGN-Up_wpr-_FFM';

void main() async {
  // Перехват глобальных ошибок
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Инициализация Supabase
    bool supabaseInitialized = false;
    try {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
      );
      developer.log('Supabase успешно инициализирован', name: 'Supabase');
      supabaseInitialized = true;
    } catch (e) {
      developer.log(
        'Ошибка при инициализации Supabase: $e',
        name: 'Supabase',
        error: e,
      );
      // Здесь можно показать диалог с ошибкой или попытаться восстановить соединение
    }

    // Инициализация Firebase
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );

    // Инициализация ServiceLocator только если Supabase инициализирован
    if (supabaseInitialized) {
      try {
        ServiceLocator().init(Supabase.instance.client);
      } catch (e) {
        developer.log(
          'Ошибка при инициализации ServiceLocator: $e',
          name: 'ServiceLocator',
          error: e,
        );
      }
    } else {
      developer.log(
        'ServiceLocator не инициализирован из-за ошибки в Supabase',
        name: 'ServiceLocator',
      );
      // Здесь можно создать заглушку для репозиториев или использовать локальные данные
    }

    // runApp(MyApp());
    runApp(WIPAPP());
  }, (error, stackTrace) {
    // Логируем необработанные исключения
    developer.log(
      'Необработанное исключение: $error',
      name: 'Global',
      error: error,
      stackTrace: stackTrace,
    );
  });
}

// Класс для мониторинга BLoC событий и ошибок
class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    developer.log('${bloc.runtimeType} $event', name: 'BlocEvent');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    developer.log(
      '${bloc.runtimeType} $error',
      name: 'BlocError',
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    // Регистрируем наблюдателя для блоков
    Bloc.observer = AppBlocObserver();
  }

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final serviceLocator = ServiceLocator();

    return MultiBlocProvider(
      providers: [
        BlocProvider<DeveloperBloc>(
          create: (context) => serviceLocator.getDeveloperBloc(),
        ),
        BlocProvider<ProjectsBloc>(
          create: (context) => serviceLocator.getProjectsBloc(),
        ),
        BlocProvider<ProjectDetailsBloc>(
          create: (context) => serviceLocator.getProjectDetailsBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Станислав П. | Портфолио',
        theme: ThemeData(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.accent,
            secondary: AppColors.accent2,
            // background: AppColors.background,
            surface: AppColors.cardBackground,
          ),
          scaffoldBackgroundColor: AppColors.background,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
        ),
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
        routerConfig: appRouter.config(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class WIPAPP extends StatelessWidget {
  WIPAPP({super.key});

  final AnimatedMeshGradientController _meshController =
      AnimatedMeshGradientController();

  void toggleAnimation() {
    _meshController.isAnimating.value
        ? _meshController.stop()
        : _meshController.start();
  }

  @override
  Widget build(BuildContext context) {
    toggleAnimation();

    return MaterialApp(
      title: 'WIP App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: AnimatedMeshGradient(
          colors: const [
            AppColors.blue,
            AppColors.blue2,
            AppColors.purp,
            AppColors.purp2,
          ],
          options: AnimatedMeshGradientOptions(),
          controller: _meshController,
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              IgnorePointer(
                child: AnimatedContainer(
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.sizeOf(context).width * 0.25,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.decelerate,
                  child: Image.asset(
                    'assets/images/2.webp',
                    colorBlendMode: BlendMode.darken,
                    fit: BoxFit.fitHeight,
                    // width: double.infinity,
                    // height: double.infinity,
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              const AutoSizeText(
                'Ведутся технические работы!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const AutoSizeText(
                '(Site under construction)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.gray,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const Spacer(),
              Credit()
            ],
          )),
        ),
      ),
    );
  }
}
