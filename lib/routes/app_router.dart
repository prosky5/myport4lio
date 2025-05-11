import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:myport4lio/core/presentation/screens/app_screen.dart';
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
        AutoRoute(
          path: '/',
          page: AppRoute.page,
          initial: true,
          children: [
            AutoRoute(
              path: '',
              page: HomeRoute.page,
            ),
            AutoRoute(
              path: 'about',
              page: AboutRoute.page,
            ),
            AutoRoute(
              path: 'portfolio',
              page: PortfolioRoute.page,
            ),
            AutoRoute(
              path: 'project/:id',
              page: ProjectDetailsRoute.page,
            ),
            AutoRoute(
              path: 'contacts',
              page: ContactsRoute.page,
            ),
            AutoRoute(
              path: 'resume',
              page: ResumeRoute.page,
            ),
          ],
        ),
      ];
} 