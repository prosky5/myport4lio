// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AboutRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AboutScreen(),
      );
    },
    ContactsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ContactsScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    PortfolioRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PortfolioScreen(),
      );
    },
    ProjectDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProjectDetailsRouteArgs>(
          orElse: () =>
              ProjectDetailsRouteArgs(projectId: pathParams.getInt('id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProjectDetailsScreen(
          key: args.key,
          projectId: args.projectId,
        ),
      );
    },
    ResumeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ResumeScreen(),
      );
    },
  };
}

/// generated route for
/// [AboutScreen]
class AboutRoute extends PageRouteInfo<void> {
  const AboutRoute({List<PageRouteInfo>? children})
      : super(
          AboutRoute.name,
          initialChildren: children,
        );

  static const String name = 'AboutRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ContactsScreen]
class ContactsRoute extends PageRouteInfo<void> {
  const ContactsRoute({List<PageRouteInfo>? children})
      : super(
          ContactsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ContactsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PortfolioScreen]
class PortfolioRoute extends PageRouteInfo<void> {
  const PortfolioRoute({List<PageRouteInfo>? children})
      : super(
          PortfolioRoute.name,
          initialChildren: children,
        );

  static const String name = 'PortfolioRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProjectDetailsScreen]
class ProjectDetailsRoute extends PageRouteInfo<ProjectDetailsRouteArgs> {
  ProjectDetailsRoute({
    Key? key,
    required int projectId,
    List<PageRouteInfo>? children,
  }) : super(
          ProjectDetailsRoute.name,
          args: ProjectDetailsRouteArgs(
            key: key,
            projectId: projectId,
          ),
          rawPathParams: {'id': projectId},
          initialChildren: children,
        );

  static const String name = 'ProjectDetailsRoute';

  static const PageInfo<ProjectDetailsRouteArgs> page =
      PageInfo<ProjectDetailsRouteArgs>(name);
}

class ProjectDetailsRouteArgs {
  const ProjectDetailsRouteArgs({
    this.key,
    required this.projectId,
  });

  final Key? key;

  final int projectId;

  @override
  String toString() {
    return 'ProjectDetailsRouteArgs{key: $key, projectId: $projectId}';
  }
}

/// generated route for
/// [ResumeScreen]
class ResumeRoute extends PageRouteInfo<void> {
  const ResumeRoute({List<PageRouteInfo>? children})
      : super(
          ResumeRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResumeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
