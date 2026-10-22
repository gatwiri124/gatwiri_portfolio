enum ProjectStatus { inDevelopment, pendingApproval, live }

extension ProjectStatusX on ProjectStatus {
  String get label {
    switch (this) {
      case ProjectStatus.inDevelopment:
        return 'In Development';
      case ProjectStatus.pendingApproval:
        return 'Pending Play Store Approval';
      case ProjectStatus.live:
        return 'Live App';
    }
  }
}

class Project {
  final String title;
  final String category;
  final ProjectStatus status;
  final String description;
  final List<String> techStack;

  /// Screenshot of the app shown inside the phone mockup. When `null` the card
  /// renders a branded "work in progress" panel instead.
  final String? screenshotAsset;

  /// Brand logo used by the work-in-progress panel.
  final String? logoAsset;

  final String? apkAsset;
  final String? playStoreUrl;
  final String? githubUrl;
  final String? liveUrl;

  /// Human readable label for the live link badge, e.g. `Grocery Market Web`.
  final String? liveLabel;

  const Project({
    required this.title,
    required this.category,
    required this.status,
    required this.description,
    required this.techStack,
    this.screenshotAsset,
    this.logoAsset,
    this.apkAsset,
    this.playStoreUrl,
    this.githubUrl,
    this.liveUrl,
    this.liveLabel,
  });
}
