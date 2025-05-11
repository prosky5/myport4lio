import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myport4lio/core/constants/app_colors.dart';
import 'package:myport4lio/core/constants/app_constants.dart';
import 'package:myport4lio/core/constants/app_text_styles.dart';
import 'package:myport4lio/core/presentation/widgets/error_view.dart';
import 'package:myport4lio/features/developer/bloc/developer_bloc.dart';
import 'package:myport4lio/features/developer/bloc/developer_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/models/developer_info.dart';
import '../../developer/bloc/developer_event.dart';

@RoutePage()
class ResumeScreen extends StatelessWidget {
  const ResumeScreen({super.key});

  Future<void> _downloadResume(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cardBackground,
      child: BlocBuilder<DeveloperBloc, DeveloperState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: CircularProgressIndicator(
                color: AppColors.accent,
              ),
            ),
            loaded: (developerInfo) => _buildContent(context, developerInfo),
            error: (message) => ErrorView(
              message: message,
              onRetry: () => context.read<DeveloperBloc>().add(const LoadDeveloperInfo()),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, DeveloperInfo developerInfo) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppConstants.menuResume,
            style: AppTextStyles.h1,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => _downloadResume(developerInfo.resumeUrl),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
            ),
            icon: const Icon(Icons.download),
            label: const Text('Скачать резюме'),
          ),
          const SizedBox(height: 48),
          Text(
            AppConstants.experience,
            style: AppTextStyles.h2,
          ),
          const SizedBox(height: 24),
          // ...developerInfo.experience.map((exp) => _buildExperienceItem(exp)),
          const SizedBox(height: 32),
          Text(
            AppConstants.education,
            style: AppTextStyles.h2,
          ),
          const SizedBox(height: 16),
          // ...developerInfo.education.map((edu) => _buildEducationItem(edu)),
        ],
      ),
    );
  }

  // Widget _buildExperienceItem(Experience experience) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 24.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(experience.company, style: AppTextStyles.h3),
  //         const SizedBox(height: 4),
  //         Text(experience.position, style: AppTextStyles.body),
  //         const SizedBox(height: 4),
  //         Text('${experience.startDate} - ${experience.endDate}',
  //           style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
  //         const SizedBox(height: 8),
  //         Text(experience.description, style: AppTextStyles.body),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildEducationItem(Education education) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 24.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(education.institution, style: AppTextStyles.h3),
  //         const SizedBox(height: 4),
  //         Text(education.degree, style: AppTextStyles.body),
  //         const SizedBox(height: 4),
  //         Text('${education.startDate} - ${education.endDate}',
  //           style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
  //       ],
  //     ),
  //   );
  // }
} 