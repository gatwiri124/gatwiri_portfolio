import 'package:flutter_test/flutter_test.dart';
import 'package:gatwiri_portfolio/app.dart';

void main() {
  testWidgets('App should build without error', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
    expect(find.text('Alex Morgan'), findsWidgets);
  });
}