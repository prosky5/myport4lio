import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myport4lio/core/constants/app_colors.dart';
import 'package:myport4lio/core/constants/app_constants.dart';
import 'package:myport4lio/core/constants/app_text_styles.dart';
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
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    message,
                    style: AppTextStyles.body,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<DeveloperBloc>().add(const LoadDeveloperInfo());
                    },
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, DeveloperInfo developerInfo) {
    return SingleChildScrollView(
      child: Padding(
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
            // TODO: Replace with actual experience data
            // ...developerInfo.experience.map((exp) => _buildExperienceItem(exp)),
          ],
        ),
      ),
    );
  }

  // Widget _buildExperienceItem(Experience experience) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 32.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           experience.position,
  //           style: AppTextStyles.h3,
  //         ),
  //         const SizedBox(height: 8),
  //         Text(
  //           experience.company,
  //           style: AppTextStyles.subtitle,
  //         ),
  //         const SizedBox(height: 4),
  //         Text(
  //           '${experience.startDate} - ${experience.endDate}',
  //           style: AppTextStyles.bodySecondary,
  //         ),
  //         const SizedBox(height: 16),
  //         Text(
  //           experience.description,
  //           style: AppTextStyles.body,
  //         ),
  //       ],
  //     ),
  //   );
  // }
} 