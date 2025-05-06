import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myport4lio/core/constants/app_colors.dart';
import 'package:myport4lio/core/constants/app_constants.dart';
import 'package:myport4lio/core/constants/app_text_styles.dart';
import 'package:myport4lio/features/developer/bloc/developer_bloc.dart';
import 'package:myport4lio/features/developer/bloc/developer_state.dart';
import 'package:myport4lio/features/home/widgets/side_menu.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<DeveloperBloc, DeveloperState>(
        builder: (context, state) {
          if (state.status == DeveloperStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.accent,
              ),
            );
          }
          
          final developerInfo = state.developerInfo;
          if (developerInfo == null) {
            return const SizedBox.shrink();
          }
          
          return ResponsiveRowColumn(
            layout: ResponsiveBreakpoints.of(context).largerThan(TABLET)
                ? ResponsiveRowColumnType.ROW
                : ResponsiveRowColumnType.COLUMN,
            rowMainAxisAlignment: MainAxisAlignment.center,
            children: [
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: SideMenu(developerInfo: developerInfo),
              ),
              ResponsiveRowColumnItem(
                rowFlex: 3,
                child: Container(
                  color: AppColors.cardBackground,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppConstants.menuResume,
                          style: AppTextStyles.h2,
                        ),
                        const SizedBox(height: 32),
                        
                        // Кнопка скачать резюме
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
                        
                        // Опыт работы
                        Text(
                          AppConstants.experience,
                          style: AppTextStyles.h3,
                        ),
                        const SizedBox(height: 24),
                        
                        // Здесь должны быть данные об опыте работы
                        // В реальном приложении их нужно получать из базы данных
                        _buildExperienceItem(
                          company: 'ООО "Технологии будущего"',
                          position: 'Старший iOS разработчик',
                          period: 'Январь 2021 - Настоящее время',
                          description: 'Разработка и поддержка мобильных приложений для iOS. '
                              'Внедрение новых технологий, проведение код-ревью, '
                              'наставничество младших разработчиков.',
                        ),
                        const Divider(color: AppColors.gray),
                        _buildExperienceItem(
                          company: 'ООО "Мобильные решения"',
                          position: 'iOS разработчик',
                          period: 'Март 2018 - Декабрь 2020',
                          description: 'Разработка нативных iOS приложений. '
                              'Интеграция с REST API, работа с CoreData, '
                              'реализация сложных пользовательских интерфейсов.',
                        ),
                        const Divider(color: AppColors.gray),
                        _buildExperienceItem(
                          company: 'ООО "Старт Ап"',
                          position: 'Стажер-разработчик',
                          period: 'Июль 2017 - Февраль 2018',
                          description: 'Участие в разработке мобильных приложений. '
                              'Изучение iOS SDK, Swift, Objective-C.',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  
  Widget _buildExperienceItem({
    required String company,
    required String position,
    required String period,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            company,
            style: AppTextStyles.h3,
          ),
          const SizedBox(height: 8),
          Text(
            position,
            style: AppTextStyles.subtitle,
          ),
          const SizedBox(height: 4),
          Text(
            period,
            style: AppTextStyles.bodySecondary,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }
} 