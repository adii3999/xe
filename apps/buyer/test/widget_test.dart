import 'package:buyer/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Buyer app shows home', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Sign in'), findsOneWidget);
  });
}
