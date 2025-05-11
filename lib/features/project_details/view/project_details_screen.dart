import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myport4lio/core/constants/app_colors.dart';
import 'package:myport4lio/core/constants/app_constants.dart';
import 'package:myport4lio/core/constants/app_text_styles.dart';
import 'package:myport4lio/features/developer/bloc/developer_bloc.dart';
import 'package:myport4lio/features/developer/bloc/developer_state.dart';
import 'package:myport4lio/features/project_details/bloc/project_details_bloc.dart';
import 'package:myport4lio/features/project_details/bloc/project_details_event.dart';
import 'package:myport4lio/features/project_details/bloc/project_details_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/models/project.dart';

@RoutePage()
class ProjectDetailsScreen extends StatefulWidget {
  final String projectId;

  const ProjectDetailsScreen({
    super.key,
    @PathParam('id') required this.projectId,
  });

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<ProjectDetailsBloc>()
        .add(LoadProjectDetails(widget.projectId));
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Не удалось открыть ссылку'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<DeveloperBloc, DeveloperState>(
        builder: (context, state) {
          return state.when(
            loading: () => const Center(
              child: CircularProgressIndicator(
                color: AppColors.accent,
              ),
            ),
            initial: () => const SizedBox.shrink(),
            loaded: (developerInfo) => Container(
              color: AppColors.cardBackground,
              child: BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.accent,
                      ),
                    ),
                    loaded: (project) => _buildContent(context, project),
                    error: (message) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppConstants.errorTitle,
                            style: AppTextStyles.h2,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            message ?? AppConstants.errorMessage,
                            style: AppTextStyles.body,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => context.router.pop(),
                            child: const Text('Назад'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            error: (_) => const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, Project project) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              style: AppTextStyles.h1,
            ),
            const SizedBox(height: 16),
            Text(
              project.description ?? "",
              style: AppTextStyles.subtitle,
            ),
            const SizedBox(height: 32),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: project.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 400,
                placeholder: (context, url) => Container(
                  color: AppColors.darkBlue,
                  height: 400,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.accent,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.darkBlue,
                  height: 400,
                  child: Center(
                    child: Text(
                      project.title.substring(0, 1),
                      style: AppTextStyles.h1.copyWith(fontSize: 72),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              project.detailText,
              style: AppTextStyles.body,
            ),
            const SizedBox(height: 32),
            Text(
              'Использованные технологии:',
              style: AppTextStyles.h3,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.technologies
                  .map((tech) => _buildTechChip(tech))
                  .toList(),
            ),
            const SizedBox(height: 32),
            if (project.appUrl != null || project.githubUrl != null)
              Row(
                children: [
                  if (project.appUrl != null)
                    ElevatedButton(
                      onPressed: () => _launchUrl(project.appUrl!),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                      ),
                      child: const Text('Открыть проект'),
                    ),
                  const SizedBox(width: 16),
                  if (project.githubUrl != null)
                    OutlinedButton(
                      onPressed: () => _launchUrl(project.githubUrl!),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.accent),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                      ),
                      child: const Text('GitHub'),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechChip(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        tech,
        style: AppTextStyles.button.copyWith(
          color: AppColors.accent,
        ),
      ),
    );
  }
}
