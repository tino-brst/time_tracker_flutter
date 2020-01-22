import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker/widgets/custom_flat_button.dart';

import '../directionality_wrapper.dart';

void main() {
  group('CustomFlatButton', () {
    testWidgets('renders the passed text', (tester) async {
      await tester.pumpWidget(
        DirectionalityWrapper(
          child: CustomFlatButton(
            'button',
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('button'), findsOneWidget);
    });

    testWidgets('executes the passed onPressed callback', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        DirectionalityWrapper(
          child: CustomFlatButton(
            'button',
            onPressed: () => pressed = true,
          ),
        ),
      );

      await tester.tap(find.text('button'));
      expect(pressed, isTrue);
    });
  });
}
