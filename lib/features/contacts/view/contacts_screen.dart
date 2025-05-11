import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myport4lio/core/constants/app_colors.dart';
import 'package:myport4lio/core/constants/app_text_styles.dart';
import 'package:myport4lio/features/developer/bloc/developer_bloc.dart';
import 'package:myport4lio/features/developer/bloc/developer_state.dart';

import '../../../core/models/developer_info.dart';
import '../../developer/bloc/developer_event.dart';

@RoutePage()
class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

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
                      context
                          .read<DeveloperBloc>()
                          .add(const LoadDeveloperInfo());
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
    final String email = developerInfo.contacts["email"] ?? '';
    final String phone = developerInfo.contacts["phone"] ?? '';
    final String telegram = developerInfo.contacts["telegram"] ?? '';
    final String github = developerInfo.contacts["github"] ?? '';

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Контакты',
            style: AppTextStyles.h1,
          ),
          const SizedBox(height: 32),
          if (email.isNotEmpty)
            _buildContactItem(
              context,
              Icons.email,
              'Email',
              email,
              'mailto:$email',
            ),
          const SizedBox(height: 16),
          if (phone.isNotEmpty)
            _buildContactItem(
              context,
              Icons.phone,
              'Телефон',
              phone,
              'tel:$phone',
            ),
          const SizedBox(height: 16),
          if (telegram.isNotEmpty)
            _buildContactItem(
              context,
              Icons.telegram,
              'Telegram',
              telegram,
              'https://t.me/$telegram',
            ),
          const SizedBox(height: 16),
          if (github.isNotEmpty)
            _buildContactItem(
              context,
              Icons.code,
              'GitHub',
              github,
              'https://github.com/$github',
            ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String title,
    String value,
    String url,
  ) {
    return InkWell(
      onTap: () {
        // TODO: Implement URL launcher
      },
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.accent,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodySecondary,
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: AppTextStyles.body,
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.accent,
            size: 16,
          ),
        ],
      ),
    );
  }
}
