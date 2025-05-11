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
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'welcome',
            style: AppTextStyles.h1,
          ),
          const SizedBox(height: 16),
          Text(
            developerInfo.name,
            style: AppTextStyles.h2,
          ),
          const SizedBox(height: 8),
          Text(
            developerInfo.title,
            style: AppTextStyles.h3,
          ),
          const SizedBox(height: 24),
          Text(
            developerInfo.about,
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }
}
