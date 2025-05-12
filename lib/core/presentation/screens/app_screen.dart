import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:myport4lio/core/constants/app_colors.dart';
import 'package:myport4lio/core/presentation/widgets/error_view.dart';
import 'package:myport4lio/features/developer/bloc/developer_bloc.dart';
import 'package:myport4lio/features/developer/bloc/developer_state.dart';
import 'package:myport4lio/features/developer/bloc/developer_event.dart';
import 'package:myport4lio/features/home/widgets/side_menu.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../models/developer_info.dart';

@RoutePage()
class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);

  @override
  void initState() {
    super.initState();
    context.read<DeveloperBloc>().add(const LoadDeveloperInfo());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      child: BlocBuilder<DeveloperBloc, DeveloperState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.accent),
            ),
            loaded: (developerInfo) => _buildContent(context, developerInfo),
            error: (message) => ErrorView(
              message: message,
              onRetry: () => context.read<DeveloperBloc>().add(const LoadDeveloperInfo()),
            ),
          );
        },
      ),
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ],
    );
  }

  Widget _buildContent(BuildContext context, DeveloperInfo developerInfo) {
    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      body: Row(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _controller.extended ? 300 : 80,
                child: SideMenu(
                  developerInfo: developerInfo,
                  controller: _controller,
                ),
              );
            },
          ),
          const Expanded(
            child: AutoRouter(),
          ),
        ],
      ),
    );
  }
}
