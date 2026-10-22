import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Have a mobile app idea or a project in mind? Let\u2019s build it together.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.secondary.withAlpha(170),
                height: 1.6,
              ),
        ),
        const SizedBox(height: 28),
        _ContactRow(
          icon: Icons.email_outlined,
          label: 'Email',
          value: 'gatwiriwinfred124@gmail.com',
          // Opens Gmail's compose screen in the browser, pre-addressed, so it
          // works even on devices without a desktop email client (which is
          // what a plain `mailto:` link depends on).
          url:
              'https://mail.google.com/mail/?view=cm&fs=1&to=gatwiriwinfred124@gmail.com',
        ),
        const SizedBox(height: 14),
        _ContactRow(
          icon: Icons.phone_outlined,
          label: 'Phone',
          value: '0708054438',
          url: 'tel:+254708054438',
        ),
        const SizedBox(height: 14),
        _ContactRow(
          icon: Icons.location_on_outlined,
          label: 'Location',
          value: 'Laikipia, Kenya',
          url: 'https://www.google.com/maps/search/?api=1&query=Laikipia%2C+Kenya',
        ),
        const SizedBox(height: 14),
        _ContactRow(
          icon: Icons.code,
          label: 'GitHub',
          value: 'github.com/gatwiri124',
          url: 'https://github.com/gatwiri124',
        ),
        if (!isMobile) const SizedBox(height: 8),
      ],
    );
  }
}

class _ContactRow extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final String url;

  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
  });

  @override
  State<_ContactRow> createState() => _ContactRowState();
}

class _ContactRowState extends State<_ContactRow> {
  bool _hovered = false;

  Future<void> _launch() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _launch,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _hovered ? AppTheme.primary.withAlpha(10) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _hovered
                  ? AppTheme.primary.withAlpha(60)
                  : const Color(0xFFE2E8F0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(_hovered ? 20 : 8),
                blurRadius: _hovered ? 18 : 8,
                offset: Offset(0, _hovered ? 8 : 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppTheme.primary.withAlpha(18),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(widget.icon, color: AppTheme.primary, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.secondary.withAlpha(130),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            letterSpacing: 0.4,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.value,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_outward,
                size: 18,
                color: _hovered
                    ? AppTheme.primary
                    : AppTheme.secondary.withAlpha(80),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
