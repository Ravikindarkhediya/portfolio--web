class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> techStack;
  final String? githubUrl;
  final List<String> tags;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.techStack,
    this.githubUrl,
    this.tags = const [],
  });
}