import 'package:arch_dart/arch_dart.dart';
import 'package:test/test.dart';

void main() {
  group('smoke: rules wire up correctly', () {
    test('naming rule passes when the suffix is universally satisfied',
        () async {
      await classes()
          .inFolder('lib/src/dsl')
          .shouldHaveNameEndingWith('')
          .check();
    });

    test('naming rule throws when the suffix is impossible', () async {
      expect(
        () => classes()
            .inFolder('lib/src/rules')
            .shouldHaveNameEndingWith('___NeverMatches___')
            .check(),
        throwsA(isA<Exception>()),
      );
    });

    test('error messages are emitted in English', () async {
      try {
        await classes()
            .inFolder('lib/src/dsl')
            .shouldHaveNameEndingWith('___NeverMatches___')
            .check();
        fail('expected exception');
      } catch (e) {
        final msg = e.toString();
        expect(msg.toLowerCase(), isNot(contains('método')));
        expect(msg.toLowerCase(), isNot(contains('nenhuma')));
      }
    });
  });
}
