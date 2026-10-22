import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatwiri_portfolio/app.dart';
import 'package:gatwiri_portfolio/widgets/app_logo_gallery.dart';
import 'package:gatwiri_portfolio/widgets/equal_height_row.dart';

/// Guards against RenderFlex overflows in the sections that were reworked:
/// the About stat row / logo showcase and the Featured Mobile Projects grid.
void main() {
  // 1194/1200 are the widths that reproduced the overflow: at that size the
  // projects grid switches to three columns and the cards become narrow
  // enough for the descriptions to wrap onto another line.
  const widths = <double>[
    360,
    414,
    600,
    768,
    1024,
    1180,
    1194,
    1200,
    1210,
    1280,
    1600,
  ];

  testWidgets('Sections lay out without overflow at common widths', (
    tester,
  ) async {
    for (final width in widths) {
      tester.view.physicalSize = Size(width, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();

      expect(
        tester.takeException(),
        isNull,
        reason: 'layout overflow at width $width',
      );
    }
  });

  testWidgets('Resizing the viewport keeps the layout free of overflows', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    for (final width in <double>[
      1280,
      1200,
      1194,
      1100,
      1024,
      900,
      768,
      414,
      360,
      1280,
    ]) {
      tester.view.physicalSize = Size(width, 1000);
      await tester.pumpAndSettle();

      expect(
        tester.takeException(),
        isNull,
        reason: 'layout overflow while resizing to $width',
      );
    }
  });

  testWidgets('Cards of a row share the same height', (tester) async {
    tester.view.physicalSize = const Size(1280, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    final rows = find.byType(EqualHeightRow);
    expect(rows, findsAtLeastNWidgets(3));

    for (final element in rows.evaluate()) {
      final row = element.widget as EqualHeightRow;
      final heights = <double>{};
      for (final child in row.children) {
        heights.add(tester.getSize(find.byWidget(child)).height);
      }
      expect(
        heights.length,
        1,
        reason: 'the children of a row should all share one height',
      );
    }
  });

  testWidgets('About logo showcase is open by default without overflow',
      (tester) async {
    tester.view.physicalSize = const Size(1280, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    // The five apps are visible immediately, without hovering or tapping
    // the "5 Mobile Apps" stat card.
    expect(find.text('The 5 apps I have built'), findsOneWidget);

    // The five app logos are showcased inside the gallery.
    final gallery = find.byType(AppLogoGallery);
    expect(gallery, findsOneWidget);
    for (final app in ['Nestpad', 'Ganji Traka', 'Mawe Maji Community',
      'Fresh Grocees', 'Chama App']) {
      expect(
        find.descendant(of: gallery, matching: find.text(app)),
        findsOneWidget,
        reason: 'missing $app in the showcase',
      );
    }
    expect(
      find.descendant(of: gallery, matching: find.byType(Image)),
      findsNWidgets(5),
      reason: 'each app should show its logo',
    );

    // Tapping the stat card still collapses the showcase.
    await tester.ensureVisible(find.text('Mobile Apps'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mobile Apps'));
    await tester.pumpAndSettle();
    expect(find.text('The 5 apps I have built'), findsNothing);

    // And tapping it again re-opens it.
    await tester.tap(find.text('Mobile Apps'));
    await tester.pumpAndSettle();
    expect(find.text('The 5 apps I have built'), findsOneWidget);

    expect(tester.takeException(), isNull);
  });

  testWidgets('Featured projects show the updated copy and badges', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text('Online Grocery Delivery App'), findsOneWidget);
    expect(find.text('Pending Play Store Approval'), findsOneWidget);
    expect(find.text('Grocery Market Web'), findsOneWidget);
    // Every project card now offers its release APK download.
    expect(find.text('Download APK'), findsNWidgets(5));
    expect(
      find.text(
        'Consumer-facing e-commerce grocery application backed by a live web showcase site.',
      ),
      findsOneWidget,
    );

    expect(
      find.text(
        'Community-focused application for tracking water supply records, reporting issues, and tracking utility distribution.',
      ),
      findsOneWidget,
    );

    expect(
      find.text(
        'Personal financial management app aiding users in recording, categorizing, budgeting expenses, and visualizing spending habits.',
      ),
      findsOneWidget,
    );

    expect(
      find.text(
        'Lightweight mobile note-taking application focused on clean categorization, fast search, and offline data storage.',
      ),
      findsOneWidget,
    );

    expect(
      find.text(
        'Offline-first group savings and management app supporting member records, attendance, contributions, role permissions, and hotspot device-to-device data sync.',
      ),
      findsOneWidget,
    );

    // CV aligned skills. "Supabase" also appears as a tech chip on the Chama card.
    expect(find.text('Drift'), findsOneWidget);
    expect(find.text('Supabase'), findsWidgets);
    expect(find.text('Hotspot P2P Sync'), findsOneWidget);
    expect(find.text('Git'), findsOneWidget);
    expect(find.text('Android Studio'), findsOneWidget);

    expect(tester.takeException(), isNull);
  });
}
