import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewProjects;
  final VoidCallback onContactMe;

  const HeroSection({
    super.key,
    required this.onViewProjects,
    required this.onContactMe,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: isMobile ? 40 : 80,
      ),
      child: isMobile ? _buildMobile(context) : _buildDesktop(context),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: _buildTextContent(context),
        ),
        const SizedBox(width: 48),
        Expanded(
          flex: 4,
          child: _buildImage(),
        ),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Column(
      children: [
        _buildImage(),
        const SizedBox(height: 32),
        _buildTextContent(context),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Winfred Gatwiri',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Flutter Developer & UI Designer',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppTheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'I build clean mobile applications, responsive web experiences, and user-focused digital products.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppTheme.secondary.withAlpha(180),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            FilledButton(
              onPressed: onViewProjects,
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.primary,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              ),
              child: const Text('View Projects'),
            ),
            OutlinedButton(
              onPressed: onContactMe,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.secondary,
                side: BorderSide(color: AppTheme.secondary.withAlpha(60)),
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              ),
              child: const Text('Contact Me'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop&crop=face',
        width: 300,
        height: 300,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.person, size: 80, color: Colors.grey[400]),
          );
        },
      ),
    );
  }
}
