import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:myport4lio/features/about/view/about_screen.dart';
import 'package:myport4lio/features/contacts/view/contacts_screen.dart';
import 'package:myport4lio/features/home/view/home_screen.dart';
import 'package:myport4lio/features/portfolio/view/portfolio_screen.dart';
import 'package:myport4lio/features/project_details/view/project_details_screen.dart';
import 'package:myport4lio/features/resume/view/resume_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: AboutRoute.page, path: '/about'),
    AutoRoute(page: PortfolioRoute.page, path: '/portfolio'),
    AutoRoute(page: ProjectDetailsRoute.page, path: '/portfolio/:id'),
    AutoRoute(page: ContactsRoute.page, path: '/contacts'),
    AutoRoute(page: ResumeRoute.page, path: '/resume'),
  ];
} 