import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

final Map<String, Map<String, CompilationUnit>> _parseCache = {};

Future<Map<String, CompilationUnit>> parseDirectoryWithPaths(
    String path) async {
  final cached = _parseCache[path];
  if (cached != null) return cached;

  final dartFiles = Directory(path)
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();

  final entries = await Future.wait(dartFiles.map((file) async {
    final content = await file.readAsString();
    final unit = parseString(content: content, path: file.path).unit;
    return MapEntry(file.path, unit);
  }));

  final units = Map<String, CompilationUnit>.fromEntries(entries);
  _parseCache[path] = units;
  return units;
}

/// Clears the in-memory parse cache used by [parseDirectoryWithPaths].
///
/// Call this between unrelated test runs or when source files have changed
/// and you need [parseDirectoryWithPaths] to re-read from disk.
void clearArchDartCache() {
  _parseCache.clear();
}
