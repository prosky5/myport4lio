import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myport4lio/core/constants/app_colors.dart';
import 'package:myport4lio/core/constants/app_constants.dart';
import 'package:myport4lio/core/constants/app_text_styles.dart';
import 'package:myport4lio/features/developer/bloc/developer_bloc.dart';
import 'package:myport4lio/features/developer/bloc/developer_event.dart';
import 'package:myport4lio/features/developer/bloc/developer_state.dart';
import 'package:myport4lio/features/home/widgets/side_menu.dart';
import 'package:myport4lio/routes/app_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DeveloperBloc>().add(const LoadDeveloperInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<DeveloperBloc, DeveloperState>(
        builder: (context, state) {
          if (state.status == DeveloperStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.accent,
              ),
            );
          }
          
          if (state.status == DeveloperStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppConstants.errorTitle,
                    style: AppTextStyles.h2,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    state.errorMessage ?? AppConstants.errorMessage,
                    style: AppTextStyles.body,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.read<DeveloperBloc>().add(
                      const RefreshDeveloperInfo(),
                    ),
                    child: const Text(AppConstants.retryButton),
                  ),
                ],
              ),
            );
          }
          
          final developerInfo = state.developerInfo;
          if (developerInfo == null) {
            return const SizedBox.shrink();
          }
          
          return ResponsiveRowColumn(
            layout: ResponsiveBreakpoints.of(context).largerThan(TABLET)
                ? ResponsiveRowColumnType.ROW
                : ResponsiveRowColumnType.COLUMN,
            rowMainAxisAlignment: MainAxisAlignment.center,
            children: [
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: SideMenu(developerInfo: developerInfo),
              ),
              ResponsiveRowColumnItem(
                rowFlex: 3,
                child: Container(
                  color: AppColors.cardBackground,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              developerInfo.name,
                              style: AppTextStyles.h1,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              developerInfo.title,
                              style: AppTextStyles.subtitle,
                            ),
                            Text(
                              developerInfo.location,
                              style: AppTextStyles.bodySecondary,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              developerInfo.about,
                              style: AppTextStyles.body,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
} 