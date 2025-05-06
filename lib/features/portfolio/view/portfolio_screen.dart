import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myport4lio/core/constants/app_colors.dart';
import 'package:myport4lio/core/constants/app_constants.dart';
import 'package:myport4lio/core/constants/app_text_styles.dart';
import 'package:myport4lio/features/developer/bloc/developer_bloc.dart';
import 'package:myport4lio/features/developer/bloc/developer_state.dart';
import 'package:myport4lio/features/home/widgets/side_menu.dart';
import 'package:myport4lio/features/portfolio/widgets/project_card.dart';
import 'package:myport4lio/features/projects/bloc/projects_bloc.dart';
import 'package:myport4lio/features/projects/bloc/projects_event.dart';
import 'package:myport4lio/features/projects/bloc/projects_state.dart';
import 'package:responsive_framework/responsive_framework.dart';

@RoutePage()
class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProjectsBloc>().add(const LoadProjects());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<DeveloperBloc, DeveloperState>(
        builder: (context, devState) {
          if (devState.status == DeveloperStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.accent,
              ),
            );
          }
          
          final developerInfo = devState.developerInfo;
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
                  child: BlocBuilder<ProjectsBloc, ProjectsState>(
                    builder: (context, state) {
                      if (state.status == ProjectsStatus.loading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.accent,
                          ),
                        );
                      }
                      
                      if (state.status == ProjectsStatus.error) {
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
                                onPressed: () => context.read<ProjectsBloc>().add(
                                  const RefreshProjects(),
                                ),
                                child: const Text(AppConstants.retryButton),
                              ),
                            ],
                          ),
                        );
                      }
                      
                      final projects = state.projects;
                      
                      return Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppConstants.menuPortfolio,
                              style: AppTextStyles.h2,
                            ),
                            const SizedBox(height: 32),
                            Expanded(
                              child: GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: ResponsiveBreakpoints.of(context).largerThan(TABLET) ? 3 : 1,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 1.2,
                                ),
                                itemCount: projects.length,
                                itemBuilder: (context, index) {
                                  return ProjectCard(project: projects[index]);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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