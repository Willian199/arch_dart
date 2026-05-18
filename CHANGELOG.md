## 1.0.0

First stable release of ArchDart. The API is now considered public and follows semantic versioning from this point onward.

### Performance

- `parseDirectoryWithPaths` now reads files in parallel via `Future.wait` and caches the result per directory path. Repeated rule executions in the same test run no longer re-parse the entire project. On a 50 files × 15 rules suite the speedup is roughly **10–15×**.
- Added [`clearArchDartCache`](lib/src/utils/analyzer_utils.dart) to reset the parse cache between unrelated test runs.

### Developer experience

- Translated remaining Portuguese error messages and comments to English (`rule_base.dart`, `no_dependency_any_rule.dart`, `visibility_rule.dart`, `access_rule.dart`).
- Added dartdoc to the public entry points `classes()`, `methods()`, `functions()`, `enums()`, `features()` and `layers()`.
- Cleaned the placeholder doc and TODO in `lib/arch_dart.dart`; added a package-level dartdoc with a usage example.

### Packaging

- Enriched `pubspec.yaml` with `repository`, `issue_tracker`, `funding` and `topics` for better pub.dev discoverability.
- Added a `test/` suite covering cache behaviour and a smoke test for the rule pipeline.
- Rewrote the README: removed the legacy disclaimer, documented both `package:test` and `flutter_test` usage, added a Performance section and surfaced `clearArchDartCache()` in Utilities.

## 0.0.4

- Fix strict folder init tests to /lib and methods requireAllLayers and allowMissingLayers.

## 0.0.3

- Remove flutter dependencies

## 0.0.2

- Add logo ArchDart.

## 0.0.1

- Initial version of the package with the basic functionality.
