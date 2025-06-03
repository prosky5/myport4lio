import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myport4lio/core/constants/app_colors.dart';
import 'package:myport4lio/core/constants/app_text_styles.dart';
import 'package:myport4lio/core/presentation/widgets/error_view.dart';
import 'package:myport4lio/features/portfolio/widgets/project_card.dart';
import 'package:myport4lio/features/projects/bloc/projects_bloc.dart';
import 'package:myport4lio/features/projects/bloc/projects_state.dart';
import 'package:myport4lio/features/projects/bloc/projects_event.dart';

import '../../../core/models/project.dart';
import '../../../routes/app_router.dart';

@RoutePage()
class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProjectsBloc>().add(LoadProjects());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsBloc, ProjectsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.accent),
          ),
          loaded: (projects) {
            final Map<String, List<Project>> groupedByCategory =
                groupBy(projects, (Project obj) => obj.category);
            return
                // SingleChildScrollView(child:
                ListView.builder(
              itemCount: groupedByCategory.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return _buildCategorySection(
                    groupedByCategory.keys.toList()[index],
                    groupedByCategory.values.toList()[index]);
              },
              // ),
            );
          },
          error: (message) => ErrorView(
            message: message,
            onRetry: () => context.read<ProjectsBloc>().add(LoadProjects()),
          ),
        );
      },
    );
  }

  Widget _buildCategorySection(
    String category,
    List<Project> projects,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 32),
          child: Text(
            "$category {",
            style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
          ),
        ),
        _buildContent(context, projects),
        Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 32),
          child: Text(
            "};",
            style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, List<Project> projects) {
    return GridView.builder(
      padding: const EdgeInsets.all(32.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: projects.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final project = projects[index];
        // return _buildProjectCard(context, project);
        return ProjectCard(project: project);
      },
    );
  }
}
