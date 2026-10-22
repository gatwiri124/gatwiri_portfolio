import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project.dart';
import '../theme/app_theme.dart';

/// Opens an external url in the user's browser.
Future<void> openExternalUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

/// A single featured mobile project rendered as a modern, hover-responsive card.
class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0)
          ..scaleByDouble(
            _hovered ? 1.015 : 1.0,
            _hovered ? 1.015 : 1.0,
            1.0,
            1.0,
          ),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? AppTheme.primary.withAlpha(70)
                : const Color(0xFFE2E8F0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(_hovered ? 28 : 12),
              blurRadius: _hovered ? 28 : 12,
              offset: Offset(0, _hovered ? 14 : 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PhoneMockup(
                screenshotAsset: project.screenshotAsset,
                logoAsset: project.logoAsset,
                projectTitle: project.title,
                hovered: _hovered,
              ),
              const SizedBox(height: 24),
              _buildHeader(context, project),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  StatusBadge(status: project.status),
                  if (project.liveUrl != null && project.liveLabel != null)
                    LiveLinkBadge(
                      label: project.liveLabel!,
                      url: project.liveUrl!,
                    ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                project.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.secondary.withAlpha(170),
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: project.techStack
                    .map((tech) => TechPill(label: tech))
                    .toList(),
              ),
              const SizedBox(height: 20),
              _buildActions(context, project),
            ],
          ),
        ),
      ),
    );
  }

  /// App logo, project title and category subtitle.
  Widget _buildHeader(BuildContext context, Project project) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (project.logoAsset != null) ...[
          Container(
            width: 42,
            height: 42,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Image.asset(
              project.logoAsset!,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.phone_iphone_rounded,
                size: 20,
                color: AppTheme.primary.withAlpha(120),
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                project.category,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.w600,
                      height: 1.35,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context, Project project) {
    final actions = <Widget>[];

    if (project.playStoreUrl != null) {
      actions.add(
        _actionButton(
          label: 'Play Store',
          icon: Icons.shop_outlined,
          url: project.playStoreUrl!,
          filled: true,
        ),
      );
    }
    if (project.apkAsset != null) {
      actions.add(
        _actionButton(
          label: 'Download APK',
          icon: Icons.download_outlined,
          asset: project.apkAsset!,
          filled: project.playStoreUrl == null,
        ),
      );
    }
    if (project.liveUrl != null) {
      actions.add(
        _actionButton(
          label: 'View Live',
          icon: Icons.open_in_new,
          url: project.liveUrl!,
          filled: project.playStoreUrl == null && project.apkAsset == null,
        ),
      );
    }
    if (project.githubUrl != null) {
      actions.add(
        _actionButton(
          label: 'Source',
          icon: Icons.code,
          url: project.githubUrl!,
        ),
      );
    }

    if (actions.isEmpty) return const SizedBox.shrink();

    return Row(
      children: [
        for (var i = 0; i < actions.length; i++) ...[
          if (i > 0) const SizedBox(width: 10),
          Expanded(child: actions[i]),
        ],
      ],
    );
  }

  Widget _actionButton({
    required String label,
    required IconData icon,
    String? url,
    String? asset,
    bool filled = false,
  }) {
    final onPressed = url == null && asset == null
        ? null
        : () => asset != null ? _launchAsset(asset) : openExternalUrl(url!);

    if (filled) {
      return FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(label, overflow: TextOverflow.ellipsis),
        style: FilledButton.styleFrom(
          backgroundColor: AppTheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      );
    }

    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label, overflow: TextOverflow.ellipsis),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.secondary,
        side: BorderSide(color: AppTheme.secondary.withAlpha(40)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }

  Future<void> _launchAsset(String assetPath) async {
    final uri = Uri.base.resolve(assetPath);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

/// Soft-tinted status pill (amber = warning, orange = info, green = success).
class StatusBadge extends StatelessWidget {
  final ProjectStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color background;
    Color foreground;

    switch (status) {
      case ProjectStatus.inDevelopment:
        background = const Color(0xFFFEF3C7);
        foreground = const Color(0xFFB45309);
      case ProjectStatus.pendingApproval:
        background = const Color(0xFFFFEDD5);
        foreground = const Color(0xFFC2410C);
      case ProjectStatus.live:
        background = const Color(0xFFDCFCE7);
        foreground = const Color(0xFF15803D);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: foreground,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              status.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: foreground,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Tappable pill showing the live web address of a project.
class LiveLinkBadge extends StatelessWidget {
  final String label;
  final String url;

  const LiveLinkBadge({super.key, required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => openExternalUrl(url),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.primary.withAlpha(12),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppTheme.primary.withAlpha(45)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.link_rounded, size: 14, color: AppTheme.primary),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppTheme.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Small soft pill used for tech stack tags.
class TechPill extends StatelessWidget {
  final String label;

  const TechPill({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primary.withAlpha(15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppTheme.primary.withAlpha(35)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppTheme.primary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Smartphone frame with a 9:19.5 screen area, rounded corners, drop shadow and
/// a notch/camera cutout, used to showcase mobile UI screenshots.
class _PhoneMockup extends StatelessWidget {
  final String? screenshotAsset;
  final String? logoAsset;
  final String projectTitle;
  final bool hovered;

  const _PhoneMockup({
    this.screenshotAsset,
    this.logoAsset,
    required this.projectTitle,
    required this.hovered,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        height: 260,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(hovered ? 60 : 38),
              blurRadius: hovered ? 32 : 20,
              offset: Offset(0, hovered ? 16 : 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21),
          child: AspectRatio(
            aspectRatio: 9 / 19.5,
            child: Stack(
              fit: StackFit.expand,
              children: [
                _buildScreen(context),
                // Notch / camera cutout decoration
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    width: 62,
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A).withAlpha(225),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScreen(BuildContext context) {
    if (screenshotAsset != null) {
      return Image.asset(
        screenshotAsset!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _wipPanel(context),
      );
    }
    return _wipPanel(context);
  }

  /// Branded placeholder shown while an app is still being developed.
  Widget _wipPanel(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEFF6FF), Color(0xFFF8FAFC)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (logoAsset != null)
            Container(
              width: 52,
              height: 52,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Image.asset(
                logoAsset!,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.construction_rounded,
                  size: 26,
                  color: AppTheme.primary.withAlpha(140),
                ),
              ),
            ),
          if (logoAsset != null) const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              projectTitle,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppTheme.secondary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                height: 1.25,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              'In Development',
              style: TextStyle(
                color: Color(0xFFB45309),
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
