import 'package:arch_dart/src/utils/analyzer_utils.dart';
import 'package:test/test.dart';

void main() {
  group('parseDirectoryWithPaths', () {
    setUp(clearArchDartCache);

    test('returns a non-empty map of dart files', () async {
      final units = await parseDirectoryWithPaths('lib');
      expect(units, isNotEmpty);
      expect(units.keys.every((p) => p.endsWith('.dart')), isTrue);
    });

    test('returns the same map instance on subsequent calls (cached)',
        () async {
      final first = await parseDirectoryWithPaths('lib');
      final second = await parseDirectoryWithPaths('lib');
      expect(identical(first, second), isTrue);
    });

    test('clearArchDartCache forces a fresh parse', () async {
      final first = await parseDirectoryWithPaths('lib');
      clearArchDartCache();
      final second = await parseDirectoryWithPaths('lib');
      expect(identical(first, second), isFalse);
      expect(first.length, equals(second.length));
    });
  });
}
