import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todoku/main.dart';

void main() {
  setUp(() async {
    await GetIt.instance.reset();
    FlutterSecureStorage.setMockInitialValues({});
  });

  testWidgets('App landing smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TodoKuApp());
    expect(find.text('Secure Storage Connected'), findsOneWidget);
    expect(find.text('Some Random Text That Does Not Exist'), findsNothing);
  });
}
