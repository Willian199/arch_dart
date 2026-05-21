import 'package:analyzer/dart/ast/ast.dart';
import 'package:path/path.dart' as p;

import '../utils/analyzer_utils.dart';
import '../utils/rule_base.dart';
import '../utils/rule_messages.dart';

class ExtendRule extends ArchRule {
  final String package;
  final String parentClass;
  final List<String>? allowedClasses;

  ExtendRule(
    this.package,
    this.parentClass, {
    this.allowedClasses,
    this.nameFilter,
    this.checkContains = false,
    this.checkPrefix = false,
  });

  final String? nameFilter;
  final bool checkContains;
  final bool checkPrefix;

  bool _matchesName(String className) {
    final filter = nameFilter;
    if (filter == null) return true;
    if (checkContains) return className.contains(filter);
    if (checkPrefix) return className.startsWith(filter);
    return className.endsWith(filter);
  }

  @override
  Future<void> check() async {
    final unitsWithPath = await parseDirectoryWithPaths('lib');
    final violations = <String>[];

    for (final entry in unitsWithPath.entries) {
      final path = p.normalize(entry.key);
      final unit = entry.value;

      if (!path.contains(package)) continue;

      for (final declaration in unit.declarations) {
        if (declaration is ClassDeclaration) {
          final className = declaration.name.lexeme;
          if (!_matchesName(className)) continue;
          final extendsClause = declaration.extendsClause;

          if (extendsClause == null) {
            violations.add(
                RuleMessages.extendViolation(className, parentClass, path));
            continue;
          }

          final extendedClass = extendsClause.superclass.name.lexeme;

          if (allowedClasses != null) {
            if (!allowedClasses!.contains(extendedClass)) {
              violations.add(RuleMessages.extendViolation(
                  className, 'one of: ${allowedClasses!.join(", ")}', path));
            }
          } else {
            if (extendedClass != parentClass) {
              violations.add(
                  RuleMessages.extendViolation(className, parentClass, path));
            }
          }
        }
      }
    }

    if (violations.isNotEmpty) {
      throw Exception(RuleMessages.violationFound('Inheritance', violations));
    }
  }
}

