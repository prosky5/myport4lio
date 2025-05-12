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
class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
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
    );
  }

  Widget _buildContent(BuildContext context, DeveloperInfo developerInfo) {
    final String email = developerInfo.contacts["email"] ?? '';
    final String phone = developerInfo.contacts["phone"] ?? '';
    final String telegram = developerInfo.contacts["telegram"] ?? '';
    final String github = developerInfo.contacts["github"] ?? '';

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
                'Контакты',
                style: AppTextStyles.h1.copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 32),
              if (email.isNotEmpty)
                _buildContactItem(
                  context,
                  Icons.email,
                  'Email',
                  email,
                  'mailto:$email',
                  AppColors.accent,
                ),
              const SizedBox(height: 16),
              if (phone.isNotEmpty)
                _buildContactItem(
                  context,
                  Icons.phone,
                  'Телефон',
                  phone,
                  'tel:$phone',
                  AppColors.accent,
                ),
              const SizedBox(height: 16),
              if (telegram.isNotEmpty)
                _buildContactItem(
                  context,
                  Icons.telegram,
                  'Telegram',
                  telegram,
                  'https://t.me/$telegram',
                  AppColors.accent2,
                ),
              const SizedBox(height: 16),
              if (github.isNotEmpty)
                _buildContactItem(
                  context,
                  Icons.code,
                  'GitHub',
                  github,
                  'https://github.com/$github',
                  AppColors.accent2,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String title,
    String value,
    String url,
    Color iconColor,
  ) {
    return Material(
      child: InkWell(
        onTap: () {
          // TODO: Implement URL launcher
        },
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 26,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodySecondary
                        .copyWith(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: AppTextStyles.body
                        .copyWith(color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.gray,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
