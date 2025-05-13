import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:myport4lio/core/constants/app_colors.dart';
import 'package:myport4lio/core/presentation/widgets/error_view.dart';
import 'package:myport4lio/features/developer/bloc/developer_bloc.dart';
import 'package:myport4lio/features/developer/bloc/developer_event.dart';
import 'package:myport4lio/features/developer/bloc/developer_state.dart';
import 'package:myport4lio/features/home/widgets/side_menu.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../models/developer_info.dart';

@RoutePage()
class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen>
    with SingleTickerProviderStateMixin {
  late final SidebarXController _controller;

  // late final MeshGradientController _meshController;
  late final AnimatedMeshGradientController _meshController =
      AnimatedMeshGradientController();

  void toggleAnimation() {
    _meshController.isAnimating.value
        ? _meshController.stop()
        : _meshController.start();
  }

  @override
  void initState() {
    super.initState();
    // _meshController = MeshGradientController(
    //   points: [
    //     MeshGradientPoint(
    //       position: const Offset(
    //         0.2,
    //         0.6,
    //       ),
    //       color: AppColors.purp,
    //     ),
    //     MeshGradientPoint(
    //       position: const Offset(
    //         0.4,
    //         0.5,
    //       ),
    //       color: AppColors.purp2,
    //     ),
    //     MeshGradientPoint(
    //       position: const Offset(
    //         0.7,
    //         0.4,
    //       ),
    //       color: AppColors.blue,
    //     ),
    //     MeshGradientPoint(
    //       position: const Offset(
    //         0.4,
    //         0.9,
    //       ),
    //       color: AppColors.blue2,
    //     ),
    //   ],
    //   vsync: this,
    // );

    toggleAnimation();

    _controller = SidebarXController(selectedIndex: 0, extended: true);
    context.read<DeveloperBloc>().add(const LoadDeveloperInfo());
  }

  @override
  void dispose() {
    _meshController.dispose();
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
              onRetry: () =>
                  context.read<DeveloperBloc>().add(const LoadDeveloperInfo()),
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
    const animationDuration = Duration(milliseconds: 300);
    const expandedNavSize = 300.0;
    const minNavSize = 80.0;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return AnimatedMeshGradient(
                colors: const [
                  AppColors.blue,
                  AppColors.blue2,
                  AppColors.purp,
                  AppColors.purp2,
                ],
                options: AnimatedMeshGradientOptions(),
                controller: _meshController,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        AnimatedContainer(
                          color: Colors.transparent,
                          duration: animationDuration,
                          width: _controller.extended
                              ? (_controller.selectedIndex == 0
                                  ? MediaQuery.sizeOf(context).width / 2
                                  : expandedNavSize)
                              : minNavSize,
                          child: SideMenu(
                            developerInfo: developerInfo,
                            controller: _controller,
                          ),
                        ),
                        const Expanded(
                          child: AutoRouter(),
                        ),
                      ],
                    ),
                    IgnorePointer(
                      child: AnimatedContainer(
                        alignment: Alignment.bottomCenter,
                        margin: const EdgeInsets.only(
                            left: expandedNavSize / 10, top: minNavSize * 2),
                        width: _controller.selectedIndex == 0
                            ? MediaQuery.sizeOf(context).width
                            : expandedNavSize * 1.5,
                        duration: animationDuration * 2,
                        curve: Curves.decelerate,
                        child: AnimatedOpacity(
                          opacity: _controller.selectedIndex > 1 ||
                                  !_controller.extended
                              ? 0
                              : 1,
                          duration: animationDuration,
                          child: Image.asset(
                            'assets/images/1.webp',
                            colorBlendMode: BlendMode.darken,
                            fit: BoxFit.fitHeight,
                            // width: double.infinity,
                            // height: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
