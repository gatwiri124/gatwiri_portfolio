import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String url;
  final String label;

  const SocialButton({
    super.key,
    required this.icon,
    required this.url,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: IconButton(
        onPressed: () => _launchUrl(url),
        icon: Icon(icon),
        style: IconButton.styleFrom(
          foregroundColor: AppTheme.secondary,
          backgroundColor: AppTheme.surface,
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
