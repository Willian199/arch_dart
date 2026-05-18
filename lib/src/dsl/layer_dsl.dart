import '../rules/layer_rule.dart';
import '../utils/layer_validation_type.dart';

class LayerRuleBuilder {
  final List<String> _layers;
  LayerValidationType _validationType = LayerValidationType.both;
  bool _allowMissingLayers = true;

  LayerRuleBuilder(this._layers);

  LayerRuleBuilder onlyStructure() {
    _validationType = LayerValidationType.structure;
    return this;
  }

  LayerRuleBuilder onlyDependencies() {
    _validationType = LayerValidationType.dependencies;
    return this;
  }

  LayerRuleBuilder requireAllLayers() {
    _allowMissingLayers = false;
    return this;
  }

  LayerRuleBuilder allowMissingLayers() {
    _allowMissingLayers = true;
    return this;
  }

  LayerRule build() {
    return LayerRule(
      _layers,
      validationType: _validationType,
      allowMissingLayers: _allowMissingLayers,
    );
  }

  Future<void> check() async {
    await build().check();
  }
}

/// Describes the expected architectural [layerNames] (top-level folders under
/// `lib/`) and returns a builder used to assert their structure and/or the
/// allowed dependency direction between them.
///
/// ```dart
/// await layers(['presentation', 'domain', 'infra', 'core'])
///     .onlyStructure()
///     .allowMissingLayers()
///     .check();
/// ```
LayerRuleBuilder layers(List<String> layerNames) {
  return LayerRuleBuilder(layerNames);
}
