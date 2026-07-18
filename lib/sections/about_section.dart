import 'package:flutter/material.dart';
import '../widgets/stat_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'I am a Flutter developer with one year of experience building modern digital experiences. '
          'I have developed four mobile applications and two websites, gaining hands-on experience '
          'with Flutter, Firebase, UI design, and problem solving.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.7,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: StatCard(number: '1+', label: 'Year Experience'),
            ),
            SizedBox(width: isMobile ? 12 : 16),
            Expanded(
              child: StatCard(number: '4', label: 'Mobile Apps'),
            ),
            SizedBox(width: isMobile ? 12 : 16),
            Expanded(
              child: StatCard(number: '2', label: 'Websites'),
            ),
          ],
        ),
      ],
    );
  }
}
