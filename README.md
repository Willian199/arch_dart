<p align="center">
  <img src="./assets/logo.png" width="200px" align="center" alt="ArchDart logo" />
  <h1 align="center">ArchDart</h1>
  <br>
  <p align="center">
    Architectural testing framework for Dart and Flutter, inspired by Java's ArchUnit.
  </p>
</p>

<br/>

ArchDart lets you express your architectural contracts as plain Dart tests. Naming conventions, layer dependencies, clean architecture, feature isolation, cyclic dependencies — encode them once, fail the build when someone violates them.

It is pure Dart (no Flutter dependency), works with the standard `test` package, and integrates equally well with `flutter_test` in Flutter projects.

### Support 💖

If you find ArchDart useful, please consider supporting its development — 🌟 [Buy Me a Coffee](https://buymeacoffee.com/evandersondev) 🌟. Your support helps make the framework better.

<br>

## Table of Contents

- [Installation](#installation)
- [Quick Start](#quick-start)
- [Selectors](#selectors)
- [Scopes](#scopes)
- [Filters](#filters)
- [Assertions](#assertions)
  - [Modifiers and Types](#modifiers-and-types)
  - [Inheritance and Implementation](#inheritance-and-implementation)
  - [Structure, Naming, and Constructors](#structure-naming-and-constructors)
  - [Dependencies and Layers](#dependencies-and-layers)
  - [File Content](#file-content)
- [Negations](#negations)
- [Utilities](#utilities)
- [Performance](#performance)
- [Examples](#examples)
- [Contributing](#contributing)
- [License](#license)

## Installation

Add ArchDart as a dev dependency in your `pubspec.yaml`:

```yaml
dev_dependencies:
  arch_dart: ^1.0.0
```

Then run `dart pub get` (or `flutter pub get` in a Flutter project).

## Quick Start

Rules are written as plain test cases. Use the standard Dart `test` package in pure-Dart projects:

```dart
import 'package:arch_dart/arch_dart.dart';
import 'package:test/test.dart';

void main() {
  test('Repositories should end with Repository', () async {
    await classes()
        .inFolder('infra/repositories')
        .shouldHaveNameEndingWith('Repository')
        .check();
  });
}
```

Or use `flutter_test` in Flutter projects — the API is the same:

```dart
import 'package:arch_dart/arch_dart.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Domain should not depend on infra', () async {
    await classes()
        .inPackage('domain')
        .shouldNotDependOn('infra')
        .check();
  });
}
```

A rule is built by composing four parts: **selector → scope → filter → assertion**, and finished with `.check()`.

## Selectors

Selectors define the type of elements to validate:

| Selector      | Description                     |
| ------------- | ------------------------------- |
| `classes()`   | All class declarations          |
| `enums()`     | All enum declarations           |
| `methods()`   | All methods on classes/enums    |
| `functions()` | All top-level functions         |
| `features()`  | Feature folders (e.g. `lib/features/*`) |

## Scopes

Scopes narrow the elements to a specific location in the project:

| Method                | Description                                      |
| --------------------- | ------------------------------------------------ |
| `inPackage('name')`   | Logical package (e.g., `controller`, `service`)  |
| `inFolder('path')`    | Directory path in the project (e.g., `lib/core`) |
| `inDirectory('path')` | Alias for `inFolder`                             |
| `inFile('file.dart')` | A specific Dart file                             |

## Filters

Filters refine the selection further:

| Method                         | Description                              |
| ------------------------------ | ---------------------------------------- |
| `withNameEndingWith('suffix')` | Names ending with the specified suffix   |
| `withNameContaining('text')`   | Names containing the specified text      |
| `withAnnotation('name')`       | Elements with the specified annotation   |
| `withLineCountGreaterThan(n)`  | Classes with more than `n` lines of code |
| `withValueCountGreaterThan(n)` | Enums with more than `n` values          |

## Assertions

Assertions are prefixed with `should...` and represent the rule that must hold.

### Modifiers and Types

| Method                       | Description                   |
| ---------------------------- | ----------------------------- |
| `shouldBePublic()`           | Must be public                |
| `shouldBePrivate()`          | Must be private               |
| `shouldBeFinal()`            | Must be `final`               |
| `shouldBeAbstract()`         | Must be `abstract`            |
| `shouldBeSealed()`           | Must be `sealed`              |
| `shouldBeBase()`             | Must be `base`                |
| `shouldBeMixin()`            | Must be a `mixin`             |
| `shouldBeEnum()`             | Must be an `enum`             |
| `shouldBeRecord()`           | Must be a `record`            |
| `shouldBeAnnotatedWith('X')` | Must have the `@X` annotation |

### Inheritance and Implementation

| Method                         | Description                                  |
| ------------------------------ | -------------------------------------------- |
| `shouldExtend('SuperClass')`   | Must extend the specified class              |
| `shouldExtendAnyOf([...])`     | Must extend one of the specified classes     |
| `shouldImplement('Interface')` | Must implement the specified interface       |
| `shouldImplementOnly([...])`   | Must implement only the specified interfaces |

### Structure, Naming, and Constructors

| Method                                | Description                                                      |
| ------------------------------------- | ---------------------------------------------------------------- |
| `shouldHaveNameEndingWith('X')`       | Name must end with `X`                                           |
| `shouldHaveOnlyPrivateConstructors()` | All constructors must be private                                 |
| `shouldRequireAllParams()`            | Constructors must have all required parameters                   |
| `shouldHaveOnlyNamedRequiredParams()` | Constructors must have only named required parameters            |
| `shouldHaveMethodThat()`              | Methods must satisfy specific criteria (e.g., name, return type) |

### Dependencies and Layers

| Method                          | Description                                    |
| ------------------------------- | ---------------------------------------------- |
| `shouldOnlyDependOn([...])`     | Can only depend on the specified packages      |
| `shouldOnlyBeAccessedBy([...])` | Can only be accessed by the specified packages |
| `shouldBeInPackage('X')`        | Must reside in the specified package           |
| `shouldBeInAnyPackage([...])`   | Must reside in one of the specified packages   |
| `shouldBeInFolder('path')`      | Must reside in the specified folder            |
| `shouldNotHaveImports([...])`   | Must not import the specified packages         |
| `shouldNotBeImportedIn('file')` | Must not be imported in the specified file     |
| `shouldBeIndependent()`         | Features must not reference each other         |

### File Content

| Method                          | Description                                     |
| ------------------------------- | ----------------------------------------------- |
| `shouldContain('text')`         | File must contain the specified text            |
| `shouldNotBeExportedIn('file')` | File must not be exported in the specified file |

## Negations

Negations are assertions prefixed with `shouldNot...`:

| Method                              | Description                                |
| ----------------------------------- | ------------------------------------------ |
| `shouldNotBe(type)`                 | Must not be of the specified type/modifier |
| `shouldNotDependOn('package')`      | Must not depend on the specified package   |
| `shouldNotAccessPackage('package')` | Must not access the specified package      |
| `shouldNotHaveImports([...])`       | Must not import the specified packages     |
| `shouldNotContain('text')`          | File must not contain the specified text   |
| `shouldNotBeExportedIn('file')`     | Must not be exported in the specified file |

## Utilities

| Method                  | Description                                                       |
| ----------------------- | ----------------------------------------------------------------- |
| `check()`               | Executes the rule and throws if any violation is found            |
| `andAlso()`             | Chains multiple rules with AND logic                              |
| `orElse()`              | Chains multiple rules with OR logic                               |
| `shouldFail()`          | Marks the rule as expected to fail (for negative testing)         |
| `clearArchDartCache()`  | Clears the in-memory parse cache (see [Performance](#performance)) |

## Performance

Since `1.0.0`, ArchDart shares a single parsed AST across every rule executed in the same test run:

- Dart files are read in parallel (`Future.wait`) instead of one at a time.
- The resulting AST map is cached per directory path, so 15 rules over `lib/` cause only **one** filesystem scan + parse instead of 15.

For typical suites this is a roughly 10–15× speedup vs `0.0.x`.

If your test setup mutates files between rule executions (e.g. integration tests that generate code), call `clearArchDartCache()` between blocks:

```dart
import 'package:arch_dart/arch_dart.dart';
import 'package:test/test.dart';

void main() {
  setUp(clearArchDartCache);

  test('rules run on a fresh AST', () async {
    // ...
  });
}
```

In normal test runs you do **not** need to call it — the cache is per-process.

## Examples

### Enforce Naming Conventions

Every enum in `lib/core/enums` ends with `Enum` and exposes a `stringToEnum` method:

```dart
test('All enums should have stringToEnum method', () async {
  await enums()
      .inFolder('lib/core/enums')
      .shouldHaveMethodThat()
      .hasMethodNamed('stringToEnum')
      .andAlso()
      .shouldHaveNameEndingWith('Enum')
      .check();
});
```

### Enforce Layer Dependencies

Presentation must never depend on infra:

```dart
test('Presentation should not access Infra', () async {
  await classes()
      .inPackage('presentation')
      .shouldNotDependOn('infra')
      .check();
});
```

### Enforce a Use Case Contract

```dart
test('UseCases should have an execute method', () async {
  await classes()
      .inFolder('domain/usecases')
      .shouldHaveMethodThat()
      .hasMethodNamed('execute')
      .check();
});
```

### Enforce Feature Isolation

```dart
test('Features should not reference each other', () async {
  await features()
      .shouldBeIndependent()
      .check();
});
```

### Enforce Constructor Conventions

```dart
test('Entities should have all required named parameters', () async {
  await classes()
      .inFolder('domain/entities')
      .shouldHaveOnlyNamedRequiredParams()
      .check();
});
```

### Enforce the Layered Architecture

```dart
test('Layers follow the expected structure', () async {
  await layers(['presentation', 'domain', 'infra', 'core'])
      .onlyStructure()
      .allowMissingLayers()
      .check();
});
```

### Reuse a Rule via `ArchRule`

```dart
test('Custom rule example', () async {
  final ArchRule rule = classes()
      .inPackage('presentation')
      .shouldNotDependOn('infra');

  await rule.check();
});
```

## Contributing

Contributions are welcome! Please open issues or pull requests at <https://github.com/evandersondev/arch_dart>. When contributing:

- New rules should be covered by tests in `test/`.
- Update the README to reflect any user-facing change.
- Run `dart analyze lib/` and `dart test` before opening a PR.

## License

ArchDart is licensed under the [MIT License](LICENSE).
