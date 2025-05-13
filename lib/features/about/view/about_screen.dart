import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myport4lio/core/constants/app_colors.dart';
import 'package:myport4lio/core/constants/app_text_styles.dart';
import 'package:myport4lio/core/presentation/widgets/error_view.dart';
import 'package:myport4lio/features/developer/bloc/developer_bloc.dart';
import 'package:myport4lio/features/developer/bloc/developer_state.dart';
import 'package:myport4lio/features/developer/bloc/developer_event.dart';

import '../../../core/models/developer_info.dart';

@RoutePage()
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeveloperBloc, DeveloperState>(
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
    );
  }

  Widget _buildContent(BuildContext context, DeveloperInfo developerInfo) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Обо мне',
                style: AppTextStyles.h1.copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 24),
              Text(
                developerInfo.about,
                style:
                    AppTextStyles.body.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              Text(
                'Навыки',
                style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: developerInfo.skills.map((skill) {
                  return Material(
                    child: Chip(
                      label: Text(skill.name),
                      backgroundColor: AppColors.accent.withOpacity(0.08),
                      labelStyle: AppTextStyles.body.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
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
