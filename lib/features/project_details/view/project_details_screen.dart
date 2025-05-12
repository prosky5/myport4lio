import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myport4lio/core/constants/app_colors.dart';
import 'package:myport4lio/core/constants/app_text_styles.dart';
import 'package:myport4lio/core/presentation/widgets/error_view.dart';
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
    return Container(
      color: AppColors.background,
      child: BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.accent),
            ),
            loaded: (project) => _buildContent(context, project),
            error: (message) => ErrorView(
              message: message,
              onRetry: () => context
                  .read<ProjectDetailsBloc>()
                  .add(LoadProjectDetails(widget.projectId)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, Project project) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(project.title, style: AppTextStyles.h1.copyWith(color: AppColors.textPrimary)),
            const SizedBox(height: 16),
            Text(project.description ?? "-", style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.cardGradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gray.withOpacity(0.10),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: project.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 400,
                  placeholder: (context, url) => Container(
                    color: AppColors.beige,
                    height: 400,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.accent2,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.beige,
                    height: 400,
                    child: Center(
                      child: Text(
                        project.title.substring(0, 1),
                        style: AppTextStyles.h1.copyWith(fontSize: 72, color: AppColors.accent),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(project.detailText, style: AppTextStyles.body.copyWith(color: AppColors.textPrimary)),
            const SizedBox(height: 32),
            Text('Технологии', style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary)),
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
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text('Открыть проект'),
                    ),
                  const SizedBox(width: 16),
                  if (project.githubUrl != null)
                    OutlinedButton(
                      onPressed: () => _launchUrl(project.githubUrl!),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.accent2, width: 2),
                        foregroundColor: AppColors.accent2,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
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
    return Chip(
      label: Text(
        tech,
        style: AppTextStyles.body.copyWith(color: AppColors.accent, fontWeight: FontWeight.w600),
      ),
      backgroundColor: AppColors.accent.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
