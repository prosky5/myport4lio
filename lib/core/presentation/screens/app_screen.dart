import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myport4lio/core/constants/app_colors.dart';
import 'package:myport4lio/features/developer/bloc/developer_bloc.dart';
import 'package:myport4lio/features/developer/bloc/developer_state.dart';
import 'package:myport4lio/features/home/widgets/side_menu.dart';

import '../../../features/developer/bloc/developer_event.dart';
import '../../models/developer_info.dart';

@RoutePage()
class AppScreen extends StatefulWidget {
  const AppScreen({
    super.key,
  });

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  bool _isMenuExpanded = true;

  @override
  void initState() {
    super.initState();
    context.read<DeveloperBloc>().add(const LoadDeveloperInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<DeveloperBloc, DeveloperState>(
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
              child: Text(
                message,
                style: const TextStyle(color: AppColors.accent),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, DeveloperInfo developerInfo) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _isMenuExpanded ? 250 : 80,
          child: Stack(
            children: [
              SideMenu(
                developerInfo: developerInfo,
                isExpanded: _isMenuExpanded,
              ),
              Positioned(
                right: 0,
                top: 20,
                child: IconButton(
                  icon: Icon(
                    _isMenuExpanded ? Icons.chevron_left : Icons.chevron_right,
                    color: AppColors.accent,
                  ),
                  onPressed: () {
                    setState(() {
                      _isMenuExpanded = !_isMenuExpanded;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const Expanded(
          child: AutoRouter(),
        ),
      ],
    );
  }
}
