import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:myport4lio/core/constants/app_colors.dart';
import 'package:myport4lio/core/constants/app_constants.dart';
import 'package:myport4lio/core/constants/app_text_styles.dart';
import 'package:myport4lio/core/models/developer_info.dart';
import 'package:myport4lio/routes/app_router.dart';

class SideMenu extends StatelessWidget {
  final DeveloperInfo developerInfo;
  
  const SideMenu({
    super.key,
    required this.developerInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Аватарка
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: AppColors.background,
              child: Image.network(
                developerInfo.avatarUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text(
                      developerInfo.name.substring(0, 1),
                      style: AppTextStyles.h1.copyWith(fontSize: 72),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Имя
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              developerInfo.name,
              style: AppTextStyles.h3,
            ),
          ),
          
          // Меню навигации
          const SizedBox(height: 20),
          _buildMenuItem(
            context: context, 
            title: AppConstants.menuHome,
            onTap: () => context.router.replace(const HomeRoute()),
            isActive: context.router.current.name == 'HomeRoute',
          ),
          _buildMenuItem(
            context: context, 
            title: AppConstants.menuPortfolio,
            onTap: () => context.router.replace(const PortfolioRoute()),
            isActive: context.router.current.name == 'PortfolioRoute',
          ),
          _buildMenuItem(
            context: context, 
            title: AppConstants.menuContacts,
            onTap: () => context.router.replace(const ContactsRoute()),
            isActive: context.router.current.name == 'ContactsRoute',
          ),
          _buildMenuItem(
            context: context, 
            title: AppConstants.menuResume,
            onTap: () => context.router.replace(const ResumeRoute()),
            isActive: context.router.current.name == 'ResumeRoute',
          ),
        ],
      ),
    );
  }
  
  Widget _buildMenuItem({
    required BuildContext context,
    required String title,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        color: isActive ? AppColors.cardBackground : Colors.transparent,
        child: Row(
          children: [
            Text(
              title,
              style: isActive 
                ? AppTextStyles.menu.copyWith(color: AppColors.accent)
                : AppTextStyles.menu,
            ),
          ],
        ),
      ),
    );
  }
} 