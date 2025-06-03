import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:myport4lio/core/constants/app_colors.dart';
import 'package:myport4lio/core/constants/app_text_styles.dart';
import 'package:myport4lio/core/models/project.dart';
import 'package:myport4lio/routes/app_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          context.router.push(ProjectDetailsRoute(projectId: "${project.id}")),
      child: CachedNetworkImage(
        imageUrl: "${project.imagesUrl}/cover.png",
        imageBuilder: (context, imageProvider) => Container(
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
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
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              gradient: AppColors.cardShadeGradient,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project.title,
                    style: AppTextStyles.h3
                        .copyWith(color: AppColors.textPrimary)),
                const SizedBox(height: 8),
                Text(
                  project.description ?? "-",
                  style: AppTextStyles.body
                      .copyWith(color: AppColors.textSecondary),
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
                      labelStyle: AppTextStyles.body.copyWith(
                          color: AppColors.accent, fontWeight: FontWeight.w600),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: const Duration(milliseconds: 600)).slide(
            begin: const Offset(0.08, 0),
            duration: const Duration(milliseconds: 500)),
        placeholder: (context, url) => Container(
          color: AppColors.cardBackground,
          child: const Center(
            child: CircularProgressIndicator(
              color: AppColors.accent2,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: AppColors.cardBackground,
          child: Center(
            child: Text(
              project.title.substring(0, 1),
              style: AppTextStyles.h1.copyWith(color: AppColors.accent),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTechChip(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        tech,
        style: AppTextStyles.menu.copyWith(
          color: AppColors.accent,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
