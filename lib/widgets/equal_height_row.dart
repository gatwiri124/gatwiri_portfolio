import 'package:flutter/material.dart';

/// Lays out its children side by side and gives every child the same height.
///
/// The shared height is measured with a real layout pass and applied as a
/// *minimum* height, never as a fixed one.
///
/// `IntrinsicHeight` was used for this before. Intrinsic dimensions are cached
/// by the framework, so they can report a stale size once a web font finishes
/// loading at runtime. The row was then locked to a height that was smaller
/// than the content of the cards, which ended in a `RenderFlex` overflow.
/// Because the height is only a minimum, content that grows later (a font
/// swapping in and a paragraph wrapping onto another line) makes the card grow
/// instead of overflowing.
class EqualHeightRow extends StatefulWidget {
  /// The widgets laid out side by side. They share the available width
  /// equally and are all given the same height.
  final List<Widget> children;

  /// The horizontal gap between two children.
  final double spacing;

  const EqualHeightRow({
    super.key,
    required this.children,
    this.spacing = 24,
  });

  @override
  State<EqualHeightRow> createState() => _EqualHeightRowState();
}

class _EqualHeightRowState extends State<EqualHeightRow> {
  final GlobalKey _rowKey = GlobalKey();

  /// The height shared by every child; `0` until the first measurement.
  double _height = 0;

  /// Guards against queueing a measurement for every single rebuild.
  bool _measureScheduled = false;

  @override
  void initState() {
    super.initState();
    _scheduleMeasure();
  }

  @override
  void didUpdateWidget(covariant EqualHeightRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_sameChildren(oldWidget)) {
      // The row holds different content now, so the cached height is stale.
      _height = 0;
    }
    _scheduleMeasure();
  }

  /// Compares the children by key so a rebuilt row is not treated as new.
  bool _sameChildren(EqualHeightRow oldWidget) {
    if (oldWidget.children.length != widget.children.length) {
      return false;
    }
    for (var i = 0; i < widget.children.length; i++) {
      if (oldWidget.children[i].key != widget.children[i].key) {
        return false;
      }
    }
    return true;
  }

  /// Measures the row after the current frame and stores the result.
  void _scheduleMeasure() {
    if (_measureScheduled) {
      return;
    }
    _measureScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureScheduled = false;
      if (!mounted) {
        return;
      }
      final ctx = _rowKey.currentContext;
      if (ctx == null) {
        return;
      }
      final double measured = ctx.size!.height;
      if ((measured - _height).abs() > 0.5) {
        setState(() => _height = measured);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (notification) {
        // The row changed size without being rebuilt (a font swapping in, for
        // example). Measure again so the children stay aligned.
        _scheduleMeasure();
        return false;
      },
      child: SizeChangedLayoutNotifier(
        child: Row(
          key: _rowKey,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < widget.children.length; i++) ...[
              if (i > 0) SizedBox(width: widget.spacing),
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: _height),
                  child: widget.children[i],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
