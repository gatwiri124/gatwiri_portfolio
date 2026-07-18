enum ProjectType { app, website }

class Project {
  final String title;
  final String subtitle;
  final ProjectType type;
  final String? logoAsset;
  final String? apkAsset;
  final String? websiteUrl;
  final String? githubUrl;

  const Project({
    required this.title,
    required this.subtitle,
    required this.type,
    this.logoAsset,
    this.apkAsset,
    this.websiteUrl,
    this.githubUrl,
  });
}
