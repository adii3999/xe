import 'package:flutter_test/flutter_test.dart';
import 'package:seller/app.dart';

void main() {
  testWidgets('Seller app shows home', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Seller App'), findsOneWidget);
  });
}
