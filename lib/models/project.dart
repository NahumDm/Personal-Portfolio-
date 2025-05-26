class Project {
  final String title;
  final String description;
  final String imagePath;
  final String? liveUrl;
  final String? sourceCodeUrl;

  const Project({
    required this.title,
    required this.description,
    required this.imagePath,
    this.liveUrl,
    this.sourceCodeUrl,
  });
}
