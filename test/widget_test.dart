import 'package:flutter_test/flutter_test.dart';
import 'package:gatwiri_portfolio/app.dart';

void main() {
  testWidgets('App builds and shows the name and contact details', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PortfolioApp());

    expect(find.text('Winfred Gatwiri'), findsWidgets);
    expect(find.textContaining('Mobile & Flutter Application Developer'), findsWidgets);

    await tester.pumpAndSettle();

    expect(find.text('gatwiriwinfred124@gmail.com'), findsWidgets);
    expect(find.text('0708054438'), findsWidgets);
    expect(find.text('Laikipia, Kenya'), findsWidgets);
  });
}
