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
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          // color: AppColors.cardBackground,
          gradient: AppColors.bluePurpGradient,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.58),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        hoverColor: AppColors.white.withValues(alpha: 0.3),
        textStyle: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
        selectedTextStyle: AppTextStyles.body
            .copyWith(color: AppColors.accent, fontWeight: FontWeight.bold),
        hoverTextStyle: AppTextStyles.body
            .copyWith(color: AppColors.accent2, fontWeight: FontWeight.bold),
        itemTextPadding: const EdgeInsets.only(left: 32),
        selectedItemTextPadding: const EdgeInsets.only(left: 32),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: AppColors.purpTransGradient,
          boxShadow: [
            BoxShadow(
              color: AppColors.accent2.withValues(alpha: 0.10),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        iconTheme: const IconThemeData(
          color: AppColors.blue,
          size: 22,
        ),
        selectedIconTheme: const IconThemeData(
          color: AppColors.accent2,
          size: 22,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 220,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
            // color: AppColors.cardBackground,
            gradient: AppColors.bluePurpGradient),
      ),
      footerDivider: divider,
      toggleButtonBuilder: (context, extended) {
        return InkWell(
          onTap: () => controller.toggleExtended(),
          child: Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            child: IconButton(
              onPressed: null,
              icon: Icon(
                extended ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                color: AppColors.blue,
              ),
              alignment: Alignment.bottomLeft,
            ),
          ),
        );
      },
      footerBuilder: (context, extended) {
        return _buildFooter(context, extended);
      },
      items: _buildMenuItems(context),
    );
  }

  Widget _buildFooter(BuildContext context, bool extended) {
    final fullname = developerInfo.name.split(' ');
    final fulltitle = developerInfo.title.split(' ');
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (extended) ...[
            const SizedBox(height: 16),
            Text(
              "${fullname[1]} ${fullname[0].substring(0, 1)}.",
              style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 8),
            Text(
              "${fulltitle[0]} ${fulltitle[1]}",
              style:
                  AppTextStyles.body.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.start,
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
        color: AppColors.blue,
        height: .5,
      );
}
