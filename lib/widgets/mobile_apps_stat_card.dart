import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// The "5 Mobile Apps" statistic.
///
/// The app showcase is open by default; tapping the card collapses it, and
/// hovering on desktop re-opens it.
class MobileAppsStatCard extends StatefulWidget {
  final int appCount;

  /// Whether the showcase is currently open (hovered or pinned by a tap).
  final bool expanded;

  /// Toggles the showcase, pinning it open until tapped again.
  final VoidCallback onToggle;

  /// Reports hover changes so the parent can open/close the showcase.
  final ValueChanged<bool> onHoverChanged;

  const MobileAppsStatCard({
    super.key,
    required this.appCount,
    required this.expanded,
    required this.onToggle,
    required this.onHoverChanged,
  });

  @override
  State<MobileAppsStatCard> createState() => _MobileAppsStatCardState();
}

class _MobileAppsStatCardState extends State<MobileAppsStatCard> {
  bool _hovered = false;

  bool get _active => _hovered || widget.expanded;

  @override
  Widget build(BuildContext context) {
    // Tighter gutters on small screens so the label wraps between words.
    final horizontalPadding =
        MediaQuery.of(context).size.width < 768 ? 12.0 : 24.0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _hovered = true);
        widget.onHoverChanged(true);
      },
      onExit: (_) {
        setState(() => _hovered = false);
        widget.onHoverChanged(false);
      },
      child: GestureDetector(
        onTap: widget.onToggle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
          decoration: BoxDecoration(
            color: _active ? AppTheme.primary.withAlpha(12) : AppTheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _active ? AppTheme.primary.withAlpha(90) : Colors.transparent,
            ),
            boxShadow: _active
                ? [
                    BoxShadow(
                      color: AppTheme.primary.withAlpha(28),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : const [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.appCount}',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      'Mobile Apps',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(width: 4),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 220),
                    turns: _active ? 0.5 : 0,
                    child: Icon(
                      Icons.expand_more_rounded,
                      size: 18,
                      color: AppTheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
