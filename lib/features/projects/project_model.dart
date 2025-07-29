class ProjectModel {
  final String id;
  final String title;
  final String description;
  final List<String> imageUrls;
  final List<String> techStack;
  final String? githubUrl;
  final List<String> tags;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.techStack,
    this.githubUrl,
    this.tags = const [],
  });
}