import 'package:flutter/material.dart';
import '../models/skill_category.dart';
import '../widgets/skill_card.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static final List<SkillCategory> _categories = [
    SkillCategory(
      icon: Icons.code,
      title: 'Development',
      skills: ['Flutter', 'Dart', 'Firebase', 'REST APIs', 'Git'],
    ),
    SkillCategory(
      icon: Icons.design_services,
      title: 'Design',
      skills: ['Figma', 'UI Design', 'UX Research', 'Prototyping'],
    ),
    SkillCategory(
      icon: Icons.build,
      title: 'Tools',
      skills: ['VS Code', 'GitHub', 'Android Studio'],
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

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _categories.map((cat) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SkillCard(
                icon: cat.icon,
                title: cat.title,
                skills: cat.skills,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}