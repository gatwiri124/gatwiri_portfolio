/// A mobile application built by the developer, surfaced by the "5 Mobile Apps"
/// statistic in the About section.
class MobileApp {
  /// Product name, e.g. `Nestpad`.
  final String name;

  /// Short descriptor of what the app does, e.g. `Digital Notebook`.
  final String category;

  /// Path to the app logo inside `Assets/images`.
  final String logoAsset;

  /// Whether the app is still being worked on.
  final bool inDevelopment;

  const MobileApp({
    required this.name,
    required this.category,
    required this.logoAsset,
    this.inDevelopment = false,
  });
}
