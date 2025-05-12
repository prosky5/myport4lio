import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myport4lio/core/constants/app_colors.dart';
import 'package:myport4lio/core/constants/app_text_styles.dart';
import 'package:myport4lio/core/presentation/widgets/error_view.dart';
import 'package:myport4lio/features/projects/bloc/projects_bloc.dart';
import 'package:myport4lio/features/projects/bloc/projects_state.dart';
import 'package:myport4lio/features/projects/bloc/projects_event.dart';

import '../../../core/models/project.dart';
import '../../../routes/app_router.dart';

@RoutePage()
class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: BlocBuilder<ProjectsBloc, ProjectsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.accent),
            ),
            loaded: (projects) => _buildContent(context, projects),
            error: (message) => ErrorView(
              message: message,
              onRetry: () => context.read<ProjectsBloc>().add(LoadProjects()),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<Project> projects) {
    return GridView.builder(
      padding: const EdgeInsets.all(32.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return _buildProjectCard(context, project);
      },
    );
  }

  Widget _buildProjectCard(BuildContext context, Project project) {
    return InkWell(
      onTap: () => context.router.push(ProjectDetailsRoute(projectId: "${project.id}")),
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray.withOpacity(0.10),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(project.title, style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              Text(project.description ?? "-",
                style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: project.technologies.map((tech) {
                  return Chip(
                    label: Text(tech),
                    backgroundColor: AppColors.accent.withOpacity(0.08),
                    labelStyle: AppTextStyles.body.copyWith(color: AppColors.accent, fontWeight: FontWeight.w600),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
