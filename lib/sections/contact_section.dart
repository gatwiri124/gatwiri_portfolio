import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/social_button.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.email_outlined, color: AppTheme.primary, size: 20),
            const SizedBox(width: 12),
            Text(
              'winfredg274@gmail.com',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Icon(Icons.phone_outlined, color: AppTheme.primary, size: 20),
            const SizedBox(width: 12),
            Text(
              '0708054438',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Icon(Icons.location_on_outlined, color: AppTheme.primary, size: 20),
            const SizedBox(width: 12),
            Text(
              'Nairobi, Kenya',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            SocialButton(
              icon: Icons.code,
              url: 'https://github.com',
              label: 'GitHub',
            ),
            const SizedBox(width: 12),
            SocialButton(
              icon: Icons.work,
              url: 'https://linkedin.com',
              label: 'LinkedIn',
            ),
          ],
        ),
      ],
    );
  }
}
