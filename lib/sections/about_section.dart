import 'package:flutter/material.dart';
import '../models/mobile_app.dart';
import '../widgets/app_logo_gallery.dart';
import '../widgets/equal_height_row.dart';
import '../widgets/mobile_apps_stat_card.dart';
import '../widgets/stat_card.dart';

class AboutSection extends StatefulWidget {
  /// Called when one of the showcased apps is selected.
  final ValueChanged<MobileApp>? onAppSelected;

  const AboutSection({super.key, this.onAppSelected});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  /// Keeps the showcase open. Starts `true` so the five apps are visible
  /// immediately, without hovering or tapping the stat card. Tapping the
  /// stat card collapses it, and hovering re-opens it.
  bool _pinned = true;

  /// Set while the pointer is over the stat card.
  bool _hovered = false;

  bool get _expanded => _pinned || _hovered;

  static const List<MobileApp> _apps = [
    MobileApp(
      name: 'Nestpad',
      category: 'Digital Notebook',
      logoAsset: 'Assets/images/logo1.png',
    ),
    MobileApp(
      name: 'Ganji Traka',
      category: 'Expense Tracker',
      logoAsset: 'Assets/images/logo2.png',
    ),
    MobileApp(
      name: 'Mawe Maji Community',
      category: 'Water Records',
      logoAsset: 'Assets/images/logo3.png',
    ),
    MobileApp(
      name: 'Fresh Grocees',
      category: 'Fresh Grocery',
      logoAsset: 'Assets/images/logo4.png',
    ),
    MobileApp(
      name: 'Chama App',
      category: 'In Development',
      logoAsset: 'Assets/images/logo5.png',
      inDevelopment: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'I am a Mobile & Flutter Application Developer with hands-on experience building modern, '
          'production-ready mobile products. I have shipped five mobile applications across fintech, '
          'retail, utilities, and productivity, working with Flutter, Firebase, REST APIs, and clean UI design.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.7,
          ),
        ),
        const SizedBox(height: 32),
        EqualHeightRow(
          key: const ValueKey('about-stats'),
          spacing: isMobile ? 12 : 16,
          children: [
            const StatCard(
              key: ValueKey('stat-years'),
              number: '1+',
              label: 'Year Experience',
            ),
            MobileAppsStatCard(
              key: const ValueKey('stat-apps'),
              appCount: _apps.length,
              expanded: _expanded,
              onToggle: () => setState(() => _pinned = !_pinned),
              onHoverChanged: (hovered) {
                if (_hovered != hovered) {
                  setState(() => _hovered = hovered);
                }
              },
            ),
            const StatCard(
              key: ValueKey('stat-live'),
              number: '3',
              label: 'Live on Stores',
            ),
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: _expanded
              ? Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: AppLogoGallery(
                    apps: _apps,
                    onAppTap: widget.onAppSelected,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
