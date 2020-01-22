import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker/widgets/custom_flat_button.dart';

void main() {
  group('CustomFlatButton', () {
    testWidgets('renders the passed text', (tester) async {
      await pumpCustomFlatButton(tester, 'button');

      expect(find.text('button'), findsOneWidget);
    });

    testWidgets('executes the passed onPressed callback', (tester) async {
      var pressed = false;

      await pumpCustomFlatButton(
        tester,
        'button',
        onPressed: () => pressed = true,
      );

      await tester.tap(find.text('button'));

      expect(pressed, isTrue);
    });
  });
}

Future<void> pumpCustomFlatButton(WidgetTester tester, String text, {VoidCallback onPressed}) {
  return tester.pumpWidget(Directionality(
    textDirection: TextDirection.ltr,
    child: CustomFlatButton(
      text,
      onPressed: onPressed,
    ),
  ));
}
