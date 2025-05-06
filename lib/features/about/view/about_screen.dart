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

@RoutePage()
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppConstants.aboutMe,
                            style: AppTextStyles.h2,
                          ),
                          const SizedBox(height: 32),
                          Text(
                            developerInfo.about,
                            style: AppTextStyles.body,
                          ),
                          const SizedBox(height: 48),
                          
                          // Технические навыки
                          Text(
                            AppConstants.skills,
                            style: AppTextStyles.h3,
                          ),
                          const SizedBox(height: 24),
                          ...developerInfo.skills.where((skill) => skill.category == 'technical').map(
                            (skill) => Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        skill.name,
                                        style: AppTextStyles.body,
                                      ),
                                      Row(
                                        children: List.generate(
                                          5,
                                          (index) => Padding(
                                            padding: const EdgeInsets.only(left: 4.0),
                                            child: Icon(
                                              Icons.circle,
                                              size: 12,
                                              color: index < skill.level
                                                  ? AppColors.accent
                                                  : AppColors.gray,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  LinearProgressIndicator(
                                    value: skill.level / 5,
                                    backgroundColor: AppColors.background,
                                    valueColor: const AlwaysStoppedAnimation<Color>(
                                      AppColors.accent,
                                    ),
                                    minHeight: 6,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 48),
                          
                          // Софт-скиллы
                          Text(
                            AppConstants.softSkills,
                            style: AppTextStyles.h3,
                          ),
                          const SizedBox(height: 24),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: developerInfo.softSkills
                                .map((skill) => _buildSkillChip(skill))
                                .toList(),
                          ),
                        ],
                      ),
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
  
  Widget _buildSkillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        skill,
        style: AppTextStyles.button.copyWith(
          color: AppColors.accent,
        ),
      ),
    );
  }
} 