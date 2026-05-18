/// ArchDart — a Dart/Flutter architectural testing framework inspired by
/// ArchUnit for Java.
///
/// Write expressive, fluent rules that fail your test suite when the
/// architectural contracts of your codebase are violated.
///
/// ```dart
/// import 'package:arch_dart/arch_dart.dart';
/// import 'package:test/test.dart';
///
/// void main() {
///   test('Domain must not depend on infra or presentation', () async {
///     await classes()
///         .inPackage('domain')
///         .shouldNotDependOnAny(['infra', 'presentation'])
///         .check();
///   });
/// }
/// ```
///
/// Entry points:
///
/// - [classes], [methods], [functions], [enums] — select code elements
/// - [features] — select feature folders for isolation checks
/// - [layers] — describe layered architecture rules
///
/// See <https://github.com/evandersondev/arch_dart> for the full guide.
library;

export 'src/dsl/arch_classes.dart';
export 'src/dsl/layer_dsl.dart';
export 'src/rules/annotation_rule.dart';
export 'src/rules/extend_rule.dart';
export 'src/rules/field_rule.dart';
export 'src/rules/hava_field_rule.dart';
export 'src/rules/implement_rule.dart';
export 'src/rules/import_rule.dart';
export 'src/rules/layer_rule.dart';
export 'src/rules/method_rule.dart';
export 'src/rules/method_rule_type.dart';
export 'src/rules/naming_rule.dart';
export 'src/rules/no_dependency_rule.dart';
export 'src/rules/only_dependency_rule.dart';
export 'src/rules/reside_in_rule.dart';
export 'src/rules/visibility_rule.dart';
export 'src/selectors/class_that.dart';
export 'src/utils/analyzer_utils.dart' show clearArchDartCache;
export 'src/utils/rule_base.dart';
