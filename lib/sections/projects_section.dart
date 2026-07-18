import 'package:flutter/material.dart';
import '../models/project.dart';
import '../widgets/project_card.dart';
import '../widgets/section_title.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  static final List<Project> _apps = [
    Project(
      title: 'Nest Pad',
      subtitle: 'Digital Notebook',
      type: ProjectType.app,
      logoAsset: 'Assets/images/logo1.png',
      apkAsset: 'Assets/APK/app1-release.apk',
    ),
    Project(
      title: 'Ganji Traka',
      subtitle: 'Expense Tracker',
      type: ProjectType.app,
      logoAsset: 'Assets/images/logo2.png',
      apkAsset: 'Assets/APK/app2-debug.apk',
    ),
    Project(
      title: 'Majimawe',
      subtitle: 'Mawemaji',
      type: ProjectType.app,
      logoAsset: 'Assets/images/logo3.png',
      apkAsset: 'Assets/APK/app3-debug.apk',
    ),
    Project(
      title: 'Fresh Grocees',
      subtitle: 'Grocery Marketplace',
      type: ProjectType.app,
      logoAsset: 'Assets/images/logo4.png',
      apkAsset: 'Assets/APK/app4-debug.apk',
    ),
  ];

  static final List<Project> _websites = [
    Project(
      title: 'FreshGrocees',
      subtitle: 'Online Grocery Store',
      type: ProjectType.website,
      websiteUrl: 'https://freshgrocees.site',
      githubUrl: 'https://github.com',
    ),
    Project(
      title: 'Portfolio',
      subtitle: 'Personal Portfolio Website',
      type: ProjectType.website,
      githubUrl: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGrid(context, _apps, 2),
        const SizedBox(height: 40),
        const SectionTitle(title: 'Websites'),
        const SizedBox(height: 24),
        _buildGrid(context, _websites, 2),
      ],
    );
  }

  Widget _buildGrid(BuildContext context, List<Project> projects, int crossAxisCount) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final cols = isMobile ? 1 : crossAxisCount;

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.count(
          crossAxisCount: cols,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: isMobile ? 0.85 : 0.9,
          children: projects.map((project) {
            return ProjectCard(project: project);
          }).toList(),
        );
      },
    );
  }
}
