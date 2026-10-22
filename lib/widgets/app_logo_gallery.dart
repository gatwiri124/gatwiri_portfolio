import 'package:flutter/material.dart';
import '../models/mobile_app.dart';
import '../models/project.dart';
import '../theme/app_theme.dart';
import 'project_card.dart';

/// Expandable showcase of the mobile apps behind the "5 Mobile Apps" statistic.
///
/// Renders one tile per app, each pairing the brand logo with the product
/// name, a short descriptor and the current release status.
class AppLogoGallery extends StatelessWidget {
  final List<MobileApp> apps;

  /// Called when an app tile is tapped, e.g. to scroll down to the projects.
  final ValueChanged<MobileApp>? onAppTap;

  const AppLogoGallery({super.key, required this.apps, this.onAppTap});

  static const double _spacing = 14;
  static const double _minTileWidth = 130;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primary.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.apps_rounded, size: 18, color: AppTheme.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'The 5 apps I have built',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Tap an app to jump to its project in the section below.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.secondary.withAlpha(140),
                ),
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns =
                  ((constraints.maxWidth + _spacing) / _minTileWidth)
                      .floor()
                      .clamp(1, apps.length);
              final tileWidth =
                  (constraints.maxWidth - _spacing * (columns - 1)) / columns;

              return Wrap(
                spacing: _spacing,
                runSpacing: _spacing,
                children: [
                  for (final app in apps)
                    SizedBox(
                      width: tileWidth,
                      child: _AppTile(
                        app: app,
                        onTap: onAppTap == null
                            ? null
                            : () => onAppTap!(app),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AppTile extends StatelessWidget {
  final MobileApp app;
  final VoidCallback? onTap;

  const _AppTile({required this.app, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Image.asset(
                  app.logoAsset,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.apps_rounded,
                    color: AppTheme.primary.withAlpha(120),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                app.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                app.category,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.secondary.withAlpha(140),
                      height: 1.3,
                    ),
              ),
              const SizedBox(height: 12),
              StatusBadge(
                status: app.inDevelopment
                    ? ProjectStatus.inDevelopment
                    : ProjectStatus.live,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
