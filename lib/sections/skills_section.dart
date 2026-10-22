import 'package:flutter/material.dart';
import '../models/skill_category.dart';
import '../widgets/equal_height_row.dart';
import '../widgets/skill_card.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static final List<SkillCategory> _categories = [
    SkillCategory(
      icon: Icons.code,
      title: 'Development',
      skills: [
        'Flutter',
        'Dart',
        'SQLite',
        'Drift',
        'Supabase',
        'Firebase',
        'REST APIs',
        'Hotspot P2P Sync',
      ],
    ),
    SkillCategory(
      icon: Icons.design_services,
      title: 'Design',
      skills: ['Figma', 'UI Design', 'UX Research', 'Prototyping'],
    ),
    SkillCategory(
      icon: Icons.build,
      title: 'Tools',
      skills: ['VS Code', 'GitHub', 'Git', 'Android Studio'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    if (isMobile) {
      return Column(
        children: _categories.map((cat) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SkillCard(
              icon: cat.icon,
              title: cat.title,
              skills: cat.skills,
            ),
          );
        }).toList(),
      );
    }

    return EqualHeightRow(
      key: const ValueKey('skills-row'),
      // The cards carry their own horizontal padding, so no extra gap is
      // needed between them.
      spacing: 0,
      children: _categories.map((cat) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SkillCard(
            key: ValueKey(cat.title),
            icon: cat.icon,
            title: cat.title,
            skills: cat.skills,
          ),
        );
      }).toList(),
    );
  }
}