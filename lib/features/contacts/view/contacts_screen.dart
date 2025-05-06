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
class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  Future<void> _launchUrl(String url) async {
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
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppConstants.menuContacts,
                            style: AppTextStyles.h2,
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: 500,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildContactItem(
                                  icon: Icons.email_outlined,
                                  title: 'Email',
                                  value: developerInfo.contacts['email'] ?? '',
                                  onTap: () => _launchUrl(
                                    'mailto:${developerInfo.contacts['email']}',
                                  ),
                                ),
                                const Divider(color: AppColors.gray),
                                _buildContactItem(
                                  icon: Icons.phone_outlined,
                                  title: 'Телефон',
                                  value: developerInfo.contacts['phone'] ?? '',
                                  onTap: () => _launchUrl(
                                    'tel:${developerInfo.contacts['phone']}',
                                  ),
                                ),
                                const Divider(color: AppColors.gray),
                                _buildContactItem(
                                  icon: Icons.telegram,
                                  title: 'Telegram',
                                  value: developerInfo.contacts['telegram'] ?? '',
                                  onTap: () => _launchUrl(
                                    AppConstants.telegramUrl,
                                  ),
                                ),
                                const Divider(color: AppColors.gray),
                                _buildContactItem(
                                  icon: Icons.code,
                                  title: 'GitHub',
                                  value: developerInfo.contacts['github'] ?? '',
                                  onTap: () => _launchUrl(
                                    AppConstants.gitHubUrl,
                                  ),
                                ),
                                const Divider(color: AppColors.gray),
                                _buildContactItem(
                                  icon: Icons.work_outline,
                                  title: 'LinkedIn',
                                  value: developerInfo.contacts['linkedin'] ?? '',
                                  onTap: () => _launchUrl(
                                    AppConstants.linkedInUrl,
                                  ),
                                ),
                              ],
                            ),
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
  
  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.accent,
              size: 28,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.subtitle,
                  ),
                  Text(
                    value,
                    style: AppTextStyles.body,
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