import 'package:flutter/material.dart';
import '../models/project.dart';
import '../widgets/equal_height_row.dart';
import '../widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  static final List<Project> _projects = [
    Project(
      title: 'Fresh Grocees',
      category: 'Online Grocery Delivery App',
      status: ProjectStatus.pendingApproval,
      description:
          'Consumer-facing e-commerce grocery application backed by a live web showcase site.',
      techStack: const ['Flutter', 'Dart', 'Web Tech'],
      screenshotAsset: 'Assets/images/Screen15.png',
      logoAsset: 'Assets/images/logo4.png',
      liveUrl: 'https://gatwiri124.github.io/grocery_market_web/',
      liveLabel: 'Grocery Market Web',
      // Served from web/apks/freshgrocees.apk, which flutter build web copies
      // to the site root next to the other static files.
      apkAsset: 'apks/freshgrocees.apk',
    ),
    Project(
      title: 'Mawe Maji App (Mawe Maji Community)',
      category: 'Water Utility Management & Community Records',
      status: ProjectStatus.live,
      description:
          'Community-focused application for tracking water supply records, reporting issues, and tracking utility distribution.',
      techStack: const ['Flutter', 'Dart'],
      screenshotAsset: 'Assets/images/Screen11.png',
      logoAsset: 'Assets/images/logo3.png',
      // Served from web/apks/mawemaji.apk, which flutter build web copies
      // to the site root next to the other static files.
      apkAsset: 'apks/mawemaji.apk',
    ),
    Project(
      title: 'Ganji Traka',
      category: 'Personal Expense Tracker & Analytics',
      status: ProjectStatus.live,
      description:
          'Personal financial management app aiding users in recording, categorizing, budgeting expenses, and visualizing spending habits.',
      techStack: const ['Flutter', 'SQLite'],
      screenshotAsset: 'Assets/images/Screen6.png',
      logoAsset: 'Assets/images/logo2.png',
      // Served from web/apks/ganjitraka.apk, which flutter build web copies
      // to the site root next to the other static files.
      apkAsset: 'apks/ganjitraka.apk',
    ),
    Project(
      title: 'Nest Pad',
      category: 'Digital Notebook & Notes Manager',
      status: ProjectStatus.live,
      description:
          'Lightweight mobile note-taking application focused on clean categorization, fast search, and offline data storage.',
      techStack: const ['Flutter', 'Dart'],
      screenshotAsset: 'Assets/images/screen1.png',
      logoAsset: 'Assets/images/logo1.png',
      // Served from web/apks/nestpad.apk, which flutter build web copies
      // to the site root next to the other static files.
      apkAsset: 'apks/nestpad.apk',
    ),
    Project(
      title: 'Chama App',
      category: 'Community Financial & Savings Group Platform (Offline-First)',
      status: ProjectStatus.inDevelopment,
      description:
          'Offline-first group savings and management app supporting member records, attendance, contributions, role permissions, and hotspot device-to-device data sync.',
      techStack: const ['Flutter', 'SQLite', 'Supabase', 'Hotspot Sync'],
      logoAsset: 'Assets/images/logo5.png',
      // Served from web/apks/chamaapp.apk, which flutter build web copies
      // to the site root next to the other static files.
      apkAsset: 'apks/chamaapp.apk',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        int cols = 1;
        if (width >= 1100) {
          cols = 3;
        } else if (width >= 768) {
          cols = 2;
        }

        // Group the projects into rows so every card can grow to fit its own
        // content instead of being clipped by a fixed grid aspect ratio.
        final rows = <List<Project>>[];
        for (var i = 0; i < _projects.length; i += cols) {
          rows.add(
            _projects.sublist(i, (i + cols).clamp(0, _projects.length)),
          );
        }

        return Column(
          children: [
            for (var r = 0; r < rows.length; r++) ...[
              if (r > 0) const SizedBox(height: 24),
              EqualHeightRow(
                key: ValueKey('projects-row-$r-$cols'),
                children: [
                  for (final project in rows[r])
                    ProjectCard(
                      key: ValueKey(project.title),
                      project: project,
                    ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
