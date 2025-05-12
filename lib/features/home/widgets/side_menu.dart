import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:myport4lio/core/constants/app_colors.dart';
import 'package:myport4lio/core/constants/app_constants.dart';
import 'package:myport4lio/core/constants/app_text_styles.dart';
import 'package:myport4lio/core/models/developer_info.dart';
import 'package:myport4lio/routes/app_router.dart';

class SideMenu extends StatelessWidget {
  final DeveloperInfo developerInfo;
  final bool isExpanded;
  final SidebarXController controller;

  const SideMenu({
    super.key,
    required this.developerInfo,
    required this.controller,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: controller,
      theme: SidebarXTheme(
        // margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray.withOpacity(0.08),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        hoverColor: AppColors.accent.withOpacity(0.08),
        textStyle: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
        selectedTextStyle: AppTextStyles.body.copyWith(color: AppColors.accent2, fontWeight: FontWeight.bold),
        itemTextPadding: const EdgeInsets.only(left: 32),
        selectedItemTextPadding: const EdgeInsets.only(left: 32),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: AppColors.blueGoldGradient,
          boxShadow: [
            BoxShadow(
              color: AppColors.accent2.withOpacity(0.10),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        iconTheme: const IconThemeData(
          color: AppColors.accent,
          size: 22,
        ),
        selectedIconTheme: const IconThemeData(
          color: AppColors.accent2,
          size: 24,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 220,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
        ),
      ),
      footerDivider: divider,
      footerBuilder: (context, extended) {
        return _buildFooter(context, extended);
      },
      items: _buildMenuItems(context),
    );
  }

  Widget _buildFooter(BuildContext context, bool extended) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (extended) ...[
            const SizedBox(height: 16),
            Text(
              developerInfo.name,
              style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              developerInfo.title,
              style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  List<SidebarXItem> _buildMenuItems(BuildContext context) {
    return [
      SidebarXItem(
        icon: Icons.home_outlined,
        label: AppConstants.menuHome,
        onTap: () => _handleNavigation(context, const HomeRoute()),
      ),
      SidebarXItem(
        icon: Icons.person_outline,
        label: AppConstants.menuAbout,
        onTap: () => _handleNavigation(context, const AboutRoute()),
      ),
      SidebarXItem(
        icon: Icons.work_outline,
        label: AppConstants.menuPortfolio,
        onTap: () => _handleNavigation(context, const PortfolioRoute()),
      ),
      SidebarXItem(
        icon: Icons.contact_mail_outlined,
        label: AppConstants.menuContacts,
        onTap: () => _handleNavigation(context, const ContactsRoute()),
      ),
      SidebarXItem(
        icon: Icons.description_outlined,
        label: AppConstants.menuResume,
        onTap: () => _handleNavigation(context, const ResumeRoute()),
      ),
    ];
  }

  void _handleNavigation(BuildContext context, PageRouteInfo route) {
    final currentRoute = context.router.current;
    if (currentRoute.name == route.routeName) return;
    context.router.push(route);
  }

  Widget get divider => const Divider(
    color: AppColors.gray,
    height: 1,
  );
} 