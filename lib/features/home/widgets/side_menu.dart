import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:myport4lio/core/constants/app_colors.dart';
import 'package:myport4lio/core/constants/app_constants.dart';
import 'package:myport4lio/core/constants/app_text_styles.dart';
import 'package:myport4lio/core/models/developer_info.dart';
import 'package:myport4lio/routes/app_router.dart';

class SideMenu extends StatelessWidget {
  final DeveloperInfo developerInfo;
  final bool isExpanded;

  const SideMenu({
    super.key,
    required this.developerInfo,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cardBackground,
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 32),
          _buildMenuItems(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: isExpanded ? 50 : 30,
            backgroundImage: NetworkImage(developerInfo.avatarUrl),
          ),
          if (isExpanded) ...[
            const SizedBox(height: 16),
            Text(
              developerInfo.name,
              style: AppTextStyles.h3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              developerInfo.title,
              style: AppTextStyles.body,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    final menuItems = [
      _MenuItem(
        icon: Icons.home_outlined,
        label: AppConstants.menuHome,
        route: const HomeRoute(),
      ),
      _MenuItem(
        icon: Icons.person_outline,
        label: AppConstants.menuAbout,
        route: const AboutRoute(),
      ),
      _MenuItem(
        icon: Icons.work_outline,
        label: AppConstants.menuPortfolio,
        route: const PortfolioRoute(),
      ),
      _MenuItem(
        icon: Icons.contact_mail_outlined,
        label: AppConstants.menuContacts,
        route: const ContactsRoute(),
      ),
      _MenuItem(
        icon: Icons.description_outlined,
        label: AppConstants.menuResume,
        route: const ResumeRoute(),
      ),
    ];

    return Column(
      children: menuItems.map((item) {
        return _buildMenuItem(context, item);
      }).toList(),
    );
  }

  Widget _buildMenuItem(BuildContext context, _MenuItem item) {
    final currentRoute = context.router.current;
    final isSelected = currentRoute.name == item.route.routeName;

    return ListTile(
      leading: Icon(
        item.icon,
        color: isSelected ? AppColors.accent : AppColors.gray,
      ),
      title: isExpanded
          ? Text(
              item.label,
              style: AppTextStyles.body.copyWith(
                color: isSelected ? AppColors.accent : AppColors.gray,
              ),
            )
          : null,
      selected: isSelected,
      onTap: () => _handleNavigation(context, item, currentRoute),
    );
  }

  void _handleNavigation(BuildContext context, _MenuItem item, RouteData currentRoute) {
    if (currentRoute.name == item.route.routeName) return;
    
    context.router.push(item.route);
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final PageRouteInfo route;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.route,
  });
} 